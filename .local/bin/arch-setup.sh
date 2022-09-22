#!/usr/bin/env bash
#
# This is a straight up copy of: https://github.com/maximbaz/dotfiles
#
# Arch Linux installation
#
# Bootable USB:
# - [Download](https://archlinux.org/download/) ISO and GPG files
# - Verify the ISO file: `$ pacman-key -v archlinux-<version>-dual.iso.sig`
# - Create a bootable USB with: `# dd if=archlinux*.iso of=/dev/sdX && sync`
#
# UEFI setup:
#
# - Set boot mode to UEFI, disable Legacy mode entirely.
# - Temporarily disable Secure Boot.
# - Make sure a strong UEFI administrator password is set.
# - Delete preloaded OEM keys for Secure Boot, allow custom ones.
# - Set SATA operation to AHCI mode.
#
# Run installation:
#
# - Connect to wifi via: `# iwctl station wlan0 connect WIFI-NETWORK`
# - Run: `# bash <(curl -sL https://git.io/maximbaz-install)`

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

exec 1> >(tee "stdout.log")
exec 2> >(tee "stderr.log" >&2)

export SNAP_PAC_SKIP=y

# Dialog
BACKTITLE="Arch Linux installation"

get_input() {
  title="$1"
  description="$2"

  input=$(dialog --clear --stdout --backtitle "$BACKTITLE" --title "$title" --inputbox "$description" 0 0)
  echo "$input"
}

get_password() {
  title="$1"
  description="$2"

  init_pass=$(dialog --clear --stdout --backtitle "$BACKTITLE" --title "$title" --passwordbox "$description" 0 0)
  : ${init_pass:?"password cannot be empty"}

  test_pass=$(dialog --clear --stdout --backtitle "$BACKTITLE" --title "$title" --passwordbox "$description again" 0 0)
  if [[ "$init_pass" != "$test_pass" ]]; then
    echo "Passwords did not match" >&2
    exit 1
  fi
  echo $init_pass
}

get_choice() {
  title="$1"
  description="$2"
  shift 2
  options=("$@")
  dialog --clear --stdout --backtitle "$BACKTITLE" --title "$title" --menu "$description" 0 0 0 "${options[@]}"
}

echo -e "\n### Checking UEFI boot mode"
if [ ! -f /sys/firmware/efi/fw_platform_size ]; then
  echo >&2 "You must boot in UEFI mode to continue"
  exit 2
fi

echo -e "\n### Setting up clock"
timedatectl set-ntp true
hwclock --systohc --utc

echo -e "\n### Installing additional tools"
pacman -Sy --noconfirm --needed git terminus-font dialog wget

echo -e "\n### HiDPI screens"
noyes=("Yes" "The font is too small" "No" "The font size is just fine")
hidpi=$(get_choice "Font size" "Is your screen HiDPI?" "${noyes[@]}") || exit 1
clear
[[ "$hidpi" == "Yes" ]] && font="ter-132n" || font="ter-716n"
setfont "$font"

hostname=$(get_input "Hostname" "Enter hostname") || exit 1
clear
: ${hostname:?"hostname cannot be empty"}

user=$(get_input "User" "Enter username") || exit 1
clear
: ${user:?"user cannot be empty"}

password=$(get_password "User" "Enter password") || exit 1
clear
: ${password:?"password cannot be empty"}

password_root=$(get_password "ROOT" "Enter rootfs password") || exit 1
clear
: ${password_root:?"password cannot be empty"}

devicelist=$(lsblk -dplnx size -o name,size | grep -Ev "boot|rpmb|loop" | tac | tr '\n' ' ')
read -r -a devicelist <<< $devicelist

device=$(get_choice "Installation" "Select installation disk" "${devicelist[@]}") || exit 1
clear

luks_header_device=$(get_choice "Installation" "Select disk to write LUKS header to" "${devicelist[@]}") || exit 1

clear

# partitions and mounts
#
#
echo -e "\n### Setting up partitions"
umount -R /mnt 2> /dev/null || true
cryptsetup luksClose root 2> /dev/null || true
cryptsetup luksClose home 2> /dev/null || true

part_root="$(ls ${device}* | grep -E "^${device}p?1$")"
part_home="$(ls ${device}* | grep -E "^${device}p?2$")"
part_efi="$(ls ${device}* | grep -E "^${device}p?3$")"

echo -e "\n### Formatting partitions"
mkfs.vfat -n "EFI" -F 32 "${part_efi}"

# encrypt paritions
echo -n ${password_root} | cryptsetup luksFormat --label root "${part_root}"
echo -n ${password_root} | cryptsetup open "${part_root}" root

echo -n ${password} | cryptsetup luksFormat --label home "${part_home}"
echo -n ${password} | cryptsetup open "${part_home}" home

# format encrypted
mkfs.btrfs -L btrfs_root /dev/mapper/root
mkfs.btrfs -L btrfs_home /dev/mapper/home

echo -e "\n### Setting up BTRFS / subvolumes"
mount /dev/mapper/root /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@pkgs
btrfs subvolume create /mnt/@docker
btrfs subvolume create /mnt/@logs
btrfs subvolume create /mnt/@temp
btrfs subvolume create /mnt/@swap
btrfs subvolume create /mnt/@snapshots
umount /mnt

echo -e "\n### Setting up BTRFS /home subvolumes"
mount /dev/mapper/home /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@snapshots
umount /mnt

mount -o noatime,nodiratime,compress=zstd,subvol=@ /dev/mapper/root /mnt
mkdir -p /mnt/{efi,home,mnt/btrfs-root,var/{cache/pacman,log,tmp,lib/docker},swap,.snapshots}

mount -o noatime,nodiratime,compress=zstd,subvol=/ /dev/mapper/root /mnt/mnt/btrfs-root
mount -o noatime,nodiratime,compress=zstd,subvol=@pkgs /dev/mapper/root /mnt/var/cache/pacman
mount -o noatime,nodiratime,compress=zstd,subvol=@docker /dev/mapper/root /mnt/var/lib/docker
mount -o noatime,nodiratime,compress=zstd,subvol=@logs /dev/mapper/root /mnt/var/log
mount -o noatime,nodiratime,compress=zstd,subvol=@temp /dev/mapper/root /mnt/var/tmp
mount -o noatime,nodiratime,subvol=@swap /dev/mapper/root /mnt/swap
mount -o noatime,nodiratime,compress=zstd,subvol=@snapshots /dev/mapper/root /mnt/.snapshots

# mount boot/home
mount "${part_efi}" /mnt/efi
mount -o noatime,nodiratime,compress=zstd,subvol=@ /dev/mapper/home /mnt/home

# cat >> /etc/pacman.conf << EOF
# [in0ni]
# Server = http://xi0ix.xyz/arch
# EOF

echo -e "\n### Installing packages"
pacstrap /mnt base base-devel linux linux-lts linux-firmware iwd dhcpcd man-pages texinfo git sudo zsh dash logrotate texinfo vi btrfs-progs kakoune

#
#
#
echo -e "\n### Generating base config files"
ln -sfT dash /mnt/usr/bin/sh

####
####
####
# XXX
####
####
####
# luks_header_device is not working, points to device, but needs to be partition
cryptsetup luksHeaderBackup "${part_root}" --header-backup-file /tmp/header.img
luks_header_size="$(stat -c '%s' /tmp/header.img)"
rm -f /tmp/header.img

# echo "cryptdevice=PARTLABEL=root:root:allow-discards cryptheader=LABEL=root:0:$luks_header_size root=LABEL=btrfs_root rw rootflags=subvol=@ quiet mem_sleep_default=deep" > /mnt/etc/kernel/cmdline
echo "cryptdevice=PARTLABEL=root:root:allow-discards root=LABEL=btrfs_root rw rootflags=subvol=@ quiet mem_sleep_default=deep" > /mnt/etc/kernel/cmdline

echo "FONT=$font" > /mnt/etc/vconsole.conf
genfstab -L /mnt >> /mnt/etc/fstab
echo "${hostname}" > /mnt/etc/hostname
echo "en_US.UTF-8 UTF-8" >> /mnt/etc/locale.gen
ln -sf /usr/share/zoneinfo/America/Cancun /mnt/etc/localtime
arch-chroot /mnt locale-gen
cat << EOF > /mnt/etc/mkinitcpio.conf
MODULES=()
BINARIES=()
FILES=()
HOOKS=(base consolefont udev autodetect modconf block encrypt filesystems keyboard)
EOF

#
#
#
echo -e "\n### Configuring swap file"
truncate -s 0 /mnt/swap/swapfile
chattr +C /mnt/swap/swapfile
dd if=/dev/zero of=/mnt/swap/swapfile bs=1M count=4096
chmod 600 /mnt/swap/swapfile
mkswap /mnt/swap/swapfile
echo "/swap/swapfile none swap defaults 0 0" >> /mnt/etc/fstab

#
#
#
####
####
####
# XXX
####
####
#### efi installed at /boot, and need to remove similar name (already had entry)
arch-chroot /mnt mkinitcpio -p linux -- --uefi /mnt/efi/arch.efi
efibootmgr -d ${device} -p 3 -c -L "Arch Linux" -l /arch.efi

#
#
#
echo -e "\n### Creating user"
arch-chroot /mnt useradd -m -s /usr/bin/zsh "$user"
for group in wheel vboxusers docker input; do
  arch-chroot /mnt groupadd -rf "$group"
  arch-chroot /mnt gpasswd -a "$user" "$group"
done
arch-chroot /mnt chsh -s /usr/bin/zsh
echo "$user:$password" | arch-chroot /mnt chpasswd
arch-chroot /mnt passwd -dl root

if [ "${user}" = "in0ni" ]; then
  echo -e "\n### Cloning dotfiles, running koppa"
  arch-chroot /mnt sudo -u $user bash -c 'git clone --recursive https://gitlab.com/gonzalez.af/dots ~/.dotfiles'
  arch-chroot /mnt sudo -u $user koppa mk all
  arch-chroot /mnt sudo -u $user zsh -ic true
  echo -e "\n### DONE - Check home boot, and efi works, and comment home mount"
else
  echo -e "\n### DONE - No user specific dotfiles or config has been done"
fi

echo ${device}

echo -e "\n### UNMOUNT BEFORE --> Reboot now, and after power off remember to unplug the installation USB"
# umount -R /mnt
