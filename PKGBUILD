# Maintainer: Andrés González
#
# TODO: add arc-dark theme 
#
# log:
# 1.x - legacy
# 24-0712 - initial release of sys, usr, gui structure

pkgname=(
  'paks-sys-base'
  'paks-sys-ettal'
  'paks-sys-x1'
  'paks-sys-fonts'
  'paks-sys-printers'
  'paks-usr-minimal'
  'paks-usr-admin'
  'paks-gui-desktop'
  'paks-gui-workstation'
  'paks-gui-mediacenter'
)
# YY.MM.rel
pkgver=24
pkgrel=08.7
pkgdesc='Meta-packages for custom packages'
arch=('any')
url='https://gitlab.com/gonzalez.af/dots'
license=('ISC')
pkgbase='paks'

package_paks-sys-base() {
  pkgdesc="Minimum packages for basic arch installation"
  provides=(man-db)
  replaces=(paks-base)

  depends=(
    # 'archlinux-keyring'
    'arch-secure-boot'
    'base'
    'base-devel'
    'btrfs-progs'
    'dash'
    'efibootmgr'
    'efitools'
    'intel-ucode'
    'kernel-modules-hook'
    'linux'
    'linux-firmware'
    'linux-headers'
    'logrotate'
    'pacman-contrib'
    'zsh'

    # required by server
    'firewalld'
    'pacman-hook-kernel-install'
    'reflector'
    'snap-pac'
    'terminus-font'
  )
}

package_paks-sys-ettal() {
  pkgdesc='Hardware - ettal'
  replaces=(paks-hw-ettal)

  depends=(
    'intel-media-driver'
    'vulkan-tools'
    'vulkan-intel'
  )
}

package_paks-sys-x1() {
  pkgdesc='Hardware - x1'
  replaces=(paks-hw-x1)

  depends=(
    'brightnessctl'
    'fwupd'
    'intel-compute-runtime'
    'intel-media-driver'
    'libva-utils'
    'libvdpau-va-gl'
    # 'sof-firmware'
    'tlp'
    'vulkan-intel'
  )
}

package_paks-sys-printers() {
  pkgdesc='Printers'

  depends=(
    'foomatic-db-gutenprint-ppds'
    'gutenprint'
    'hplip'
  )
}

package_paks-sys-fonts() {
  pkgdesc='Fonts'

  depends=(
    'fonts-tlwg'
    'noto-fonts-cjk'
    'noto-fonts-emoji'
    'otf-otf-overpass'
    'ttf-amiri'
    'ttf-b612'
    'ttf-cmu-typewriter'
    'ttf-courier-prime'
    'ttf-crosextra'
    'ttf-cutive-mono'
    'ttf-dm-mono-git'
    'ttf-fira-code'
    'ttf-fira-mono'
    'ttf-fira-sans'
    'ttf-font-awesome'
    'ttf-fragment-mono'
    'ttf-ibm-plex'
    'ttf-lato'
    'ttf-librebaskerville'
    'ttf-montserrat'
    'ttf-mulish'
    'ttf-nixie-one'
    'ttf-opensans'
    'ttf-poppins'
    'ttf-pt-mono'
    'ttf-rubik-vf'
    'ttf-share-gf'
    'ttf-tt2020'
    'ttf-unifont'
    'ttf-work-sans'
    'ttf-work-sans-variable'
  )
}

package_paks-usr-minimal() {
  pkgdesc='Minimal user packages, suitable for a server'
  replaces=(paks-server)

  depends=(
    # utils
    'bat'
    'bat-extras'
    'dfrs'
    'dua-cli'
    'eza'
    'fd'
    'file'
    'findutils'
    'fzf'
    # 'gawk'
    'git-prompt.zsh-git'
    'htop'
    'lshw'
    'perl-rename'
    'pipe-rename'
    'ripgrep'
    'ripgrep-all'
    'rmtrash'
    # 'sed'
    'trash-cli'
    # 'tree'
    'vivid'
    'zsh'
    'zsh-autosuggestions'
    'zsh-completions'
    'zsh-syntax-highlighting'

    # tools
    'rsync'

    # files
    'xplr'
    'gzip'
    'p7zip'
    'unrar'

    # code
    'helix'
    'git'
    'gitui'
  )
}

package_paks-usr-admin() {
  pkgdesc='Power-user packages'
  replaces=(paks-core paks-usr-base)
  provides=(paks-usr-minimal)
  # conflicts=(paks-usr-minimal)

  depends=(
    'paks-usr-minimal'

    # utils
    'man-db'
    'openssh'
    'sudo'
    'vifm'
    'vim'

    # tools
    'aurutils'
    'gopass'
    'vdpauinfo'
    'wavemon'
    'wget'
    'whois'
    'speedtest-cli'

    # files
    'exfat-utils'
    'hfsprogs'
    'ntfs-3g'

    # code
    'bash-language-server'
    'efm-langserver'
    'emmet-cli'
    'eslint'
    'flake8'
    'flow-bin'
    'lua-language-server'
    'marksman'
    'nodejs-intelephense'
    'npm'
    'patch'
    'prettier'
    'python-black'
    'python-lsp-server'
    'rust-analyzer'
    'shellcheck'
    'shfmt'
    'stylelint'
    'svelte-language-server'
    'taplo-cli'
    'termux-language-server'
    'typescript-language-server'
    'vscode-langservers-extracted'
    'vscode-php-debug'
    'vue-language-server'
    'vue-typescript-plugin'
    'xdebug'
    'yaml-language-server'
  )
}

package_paks-gui-desktop() {
  pkgdesc='Baisc Desktop Environment'
  replaces=(paks-desktop paks-usr-desktop)
  provides=(paks-sys-fonts)
  conflicts=(paks-sys-fonts)

  depends=(
    'paks-sys-fonts'

    # desktop environment
    'dunst'
    'kde-gtk-config'
    'kitty'
    'qt5-styleplugins'
    'qt5-wayland'
    'qt6gtk2'
    'qt6-wayland'
    'rofi-lbonn-wayland-git'
    'tela-circle-icon-theme-orange'
    'waybar'
    'wl-clipboard'
    'xdg-user-dirs'
    'xfce-polkit-git'
    'xorg-xwayland'
    'xsettingsd'
    'wl-mirror'

    # window manager
    'hyprland'
    'hyprpaper'
    'hypridle'
    'hyprlock'
    'xdg-desktop-portal-hyprland'

    # tools
    # 'grimshot'
    'gsimplecal'
    'gucharmap'
    'qalculate-gtk'
    'swappy'
    'wl-screenrec-git'
    'wlsunset'

    # files
    'file-roller'
    'gvfs'
    'gvfs-afc'
    'gvfs-gphoto2'
    'gvfs-mtp'
    'thunar'
    'thunar-archive-plugin'
    'thunar-media-tags-plugin'
    'thunar-volman'
    'tumbler'
    'mlocate'

    # network
    'browserpass-firefox'
    'chromium'
    'deluge-gtk'
    'firefox'
    'iwgtk'

    # viewers
    'vimiv-qt'
    'zathura-pdf-mupdf'

    # media
    'alsa-utils'
    'bluez-utils'
    'gst-plugins-bad'
    'pamixer'
    'pavucontrol'
    'pipewire-alsa'
    'pipewire-jack'
    'pipewire-pulse'
    'playerctl'
    'wireplumber'

    # players
    'mpv'
    'mpv-mpris'
    'mpv-uosc'
    'rhythmbox'
    'spotify'
  )
}

package_paks-gui-workstation() {
  pkgdesc='Workstation DE'
  replaces=()
  provides=(paks-gui-desktop)
  # conflicts=(paks-gui-desktop)

  depends=(
    'paks-gui-desktop'

    # lang
    'python'
    'rust'
    'sassc'

    # development
    'meld'
    'docker'
    'docker-compose'

    # design
    'darktable'
    'fontforge'
    'gcolor3'
    'gimp'
    'gpick'
    'hugin'
    'inkscape'
    'scribus'

    # utils
    'asciinema'
    'calibre'
    'gource'
    'rofi-rofi-emoji'

    # tools
    'android-tools'
    'clipgrab'
    'ddrescue'
    'easytag'
    'nmap'
    'osd-bin'
    'pdf2svg'
    'pdftk'
    'showmethekey'
    'smartmontools'
    'soundconverter'
    'sqlitebrowser'
    'wev'
    'which'
    'wtype'

    # office
    'hamster-time-tracker'
    'hunspell-en_us'
    'hunspell-es_any'
    'hunspell-es_es'
    'hyphen-en'
    'hyphen-es'
    'libreoffice-fresh'
    'minder'
    'obsidian'
    'xournalpp'

    # network
    'cloudflare-warp-bin'
    'filezilla'
    'signal-signal-desktop'
    'teams-teams-for-linux'

    # check
    # 'ctags'
    # 'electron'
    # 'flex'
    # 'gettext'
    # 'groff'
    # 'jre-openjdk'
    # 'libtool'
    # 'libxcrypt-compat'
  )
}

package_paks-gui-mediacenter() {
  pkgdesc='Media Center DE'
  replaces=(paks-usr-mediacenter)
  provides=(paks-gui-desktop)
  # conflicts=(paks-gui-desktop)

  depends=(
    'paks-gui-desktop'

    # system
    'autologin'
    'deluged-service'

    # media
    'kodi'
    'popcorntime-bin'

    # gaming: utils
    # 'electron'
    'emulationstation-de'
    'evremap'
    'gamemode'
    'libretro-core-info'
    'libretro-overlays'
    'libretro-shaders-slang'
    'retroarch'
    'retroarch-assets-ozone'
    'retroarch-assets-xmb'

    # gaming: emulators
    'dolphin-emu'
    'libretro-beetle-psx'
    'libretro-beetle-psx-hw'
    'libretro-citra'
    'libretro-dolphin'
    'libretro-flycast'
    'libretro-mupen64plus-next'
    'libretro-pcsx2'
    'libretro-ppsspp'
    'libretro-snes9x'
    'libretro-genesis-plus-gx'
    'mupen64plus'
    'pcsx2-latest-bin'
  )
}
