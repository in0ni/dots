#!/bin/bash
#
# https://github.com/maximbaz/dotfiles/
# =====================================
# This is but a copy of maximbaz's install, with minor changes
#
# Bootable USB:
# - [Download](https://archlinux.org/download/) ISO and GPG files
# - Verify the ISO file: `$ pacman-key -v archlinux-<version>-dual.iso.sig`
# - Create a bootable USB with: `# dd if=archlinux*.iso of=/dev/sdX && sync`
#
# UEFI setup:
# - Set boot mode to UEFI, disable Legacy mode entirely.
# - Temporarily disable Secure Boot.
# - Make sure a strong UEFI administrator password is set.
# - Delete preloaded OEM keys for Secure Boot, allow custom ones.
# - Set SATA operation to AHCI mode.
#
# Run installation:
# - Connect to wifi via: `# iwctl station wlan0 connect WIFI-NETWORK`
# - Run: `# bash <(curl -sL https://gitlab.com/gonzalez.af/dots/-/raw/master/.local/bin/arch-setup.sh)`

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

exec 1> >(tee "stdout.log")
exec 2> >(tee "stderr.log" >&2)

timezone=America/Cancun
remote_repo_name=paks
remote_repo_url=https://xi0ix.xyz/paks
remote_repo_key_url=https://xi0ix.xyz/paks/paks.asc
remote_repo_key_id=https://xi0ix.xyz/paks/paks.asc

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
pacman -Sy --noconfirm --needed git reflector terminus-font dialog wget

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

devicelist=$(lsblk -dplnx size -o name,size | grep -Ev "boot|rpmb|loop" | tac | tr '\n' ' ')
read -r -a devicelist <<< $devicelist

device=$(get_choice "Installation" "Select installation disk" "${devicelist[@]}") || exit 1
clear

echo -e "\n### Setting up fastest mirrors"
reflector --latest 30 --sort rate --save /etc/pacman.d/mirrorlist

echo -e "\n### Setting up partitions"
umount -R /mnt 2> /dev/null || true
cryptsetup luksClose luks 2> /dev/null || true

lsblk -plnx size -o name "${device}" | xargs -n1 wipefs --all
sgdisk --clear "${device}" --new 1::-551MiB "${device}" --new 2::0 --typecode 2:ef00 "${device}"
sgdisk --change-name=1:root --change-name=2:ESP "${device}"

part_root="$(ls ${device}* | grep -E "^${device}p?1$")"
part_boot="$(ls ${device}* | grep -E "^${device}p?2$")"

echo -e "\n### Formatting partitions"
mkfs.vfat -n "EFI" -F 32 "${part_boot}"
echo -n ${password} | cryptsetup luksFormat "${part_root}"
echo -n ${password} | cryptsetup open "${part_root}" root
mkfs.btrfs -L btrfs /dev/mapper/root

echo -e "\n### Setting up BTRFS subvolumes"
mount /dev/mapper/root /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@pkgs
btrfs subvolume create /mnt/@docker
btrfs subvolume create /mnt/@logs
btrfs subvolume create /mnt/@temp
btrfs subvolume create /mnt/@swap
btrfs subvolume create /mnt/@snapshots
umount /mnt

mount -o noatime,nodiratime,compress=zstd,subvol=@ /dev/mapper/root /mnt
mkdir -p /mnt/{mnt/btrfs-root,efi,home,var/{cache/pacman,log,tmp,lib/{docker}},swap,.snapshots}
mount "${part_boot}" /mnt/efi
mount -o noatime,nodiratime,compress=zstd,subvol=/ /dev/mapper/root /mnt/mnt/btrfs-root
mount -o noatime,nodiratime,compress=zstd,subvol=@home /dev/mapper/root /mnt/home
mount -o noatime,nodiratime,compress=zstd,subvol=@pkgs /dev/mapper/root /mnt/var/cache/pacman
mount -o noatime,nodiratime,compress=zstd,subvol=@docker /dev/mapper/root /mnt/var/lib/docker
mount -o noatime,nodiratime,compress=zstd,subvol=@logs /dev/mapper/root /mnt/var/log
mount -o noatime,nodiratime,compress=zstd,subvol=@temp /dev/mapper/root /mnt/var/tmp
mount -o noatime,nodiratime,compress=zstd,subvol=@swap /dev/mapper/root /mnt/swap
mount -o noatime,nodiratime,compress=zstd,subvol=@snapshots /dev/mapper/root /mnt/.snapshots

echo -e "\n### Configuring local & custom repo"
mkdir "/mnt/var/cache/pacman/${user}-local"
repo-add "/mnt/var/cache/pacman/${user}-local/${user}-local.db.tar"

if ! grep "${user}" /etc/pacman.conf > /dev/null; then
  cat >> /etc/pacman.conf << EOF
[${user}-local]
Server = file:///mnt/var/cache/pacman/${user}-local

[${remote_repo_name}]
Server = ${remote_repo_url}

[options]
CacheDir = /mnt/var/cache/pacman/pkg
CacheDir = /mnt/var/cache/pacman/${user}-local
EOF
fi

echo -e "\n### Adding custom repo key & trusting"
wget -q $remote_repo_key_url -O- | pacman-key --add -
pacman-key --finger $remote_repo_key_id
pacman-key --lsign $remote_repo_key_id
pacman -Sy

echo -e "\n### Installing packages"
pacstrap -i /mnt paks-base paks-core

echo -e "\n### Generating base config files"
ln -sfT dash /mnt/usr/bin/sh

blkuuid=$(lsblk -pn -o uuid "${device}")
echo "rd.luks.name=${blkuuid}=root rd.luks.options=${blkuuid}=tpm2-device=auto,discard root=LABEL=btrfs rw rootflags=subvol=@ quiet mem_sleep_default=deep" > /mnt/etc/kernel/cmdline

echo "FONT=$font" > /mnt/etc/vconsole.conf
genfstab -L /mnt >> /mnt/etc/fstab
echo "${hostname}" > /mnt/etc/hostname
ln -sf /usr/share/zoneinfo/"${timezone}" /mnt/etc/localtime
arch-chroot /mnt locale-gen
cat << EOF > /mnt/etc/mkinitcpio.conf
MODULES=()
BINARIES=()
FILES=()
HOOKS=(base systemd autodetect modconf kms keyboard sd-vconsole block sd-encrypt filesystems)
EOF

arch-chroot /mnt mkinitcpio -p linux
arch-chroot /mnt systemd-cryptenroll "${device}" --wipe-slot=empty --tpm2-device=auto
arch-chroot /mnt arch-secure-boot initial-setup

echo -e "\n### Configuring swap file"
btrfs filesystem mkswapfile --size 4G /mnt/swap/swapfile
echo "/swap/swapfile none swap defaults 0 0" >> /mnt/etc/fstab

echo -e "\n### Creating user"
arch-chroot /mnt useradd -m -s /usr/bin/zsh "$user"
for group in wheel video input; do
  arch-chroot /mnt groupadd -rf "$group"
  arch-chroot /mnt gpasswd -a "$user" "$group"
done
arch-chroot /mnt chsh -s /usr/bin/zsh
echo "$user:$password" | arch-chroot /mnt chpasswd
arch-chroot /mnt passwd -dl root

echo -e "\n### Setting permissions on the custom repo"
arch-chroot /mnt chown -R "$user:$user" "/var/cache/pacman/${user}-local/"

# if [ "${user}" = "maximbaz" ]; then
# echo -e "\n### Cloning dotfiles"
# arch-chroot /mnt sudo -u $user bash -c 'git clone --recursive https://github.com/maximbaz/dotfiles.git ~/.dotfiles'

# echo -e "\n### Running initial setup"
# arch-chroot /mnt /home/$user/.dotfiles/setup-system.sh
# arch-chroot /mnt sudo -u $user /home/$user/.dotfiles/setup-user.sh
# arch-chroot /mnt sudo -u $user zsh -ic true

# echo -e "\n### DONE - reboot and re-run both ~/.dotfiles/setup-*.sh scripts"
# else
# echo -e "\n### DONE - read POST_INSTALL.md for tips on configuring your setup"
# fi

echo -e "\n### Reboot now, and after power off remember to unplug the installation USB"
umount -R /mnt
