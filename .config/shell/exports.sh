export PATH=$HOME/.local/bin:$PATH

export VISUAL=nvim
export EDITOR=nvim
export SUDO_EDITOR=nvim
export PAGER=nvimpager

# firefox on wayland
export MOZ_ENABLE_WAYLAND=1

# WebRender support: https://wiki.archlinux.org/index.php/Firefox/Tweaks#Enable_WebRender_compositor
# due to issues w/ gifs on whatsapp, and video (both w/ greenbackgounds, flickering)
# opting for OpenGl compositor instead
# export MOZ_WEBRENDER=1

# https://github.com/systemd/systemd/issues/14489
export XDG_SESSION_TYPE=wayland

# see: https://wiki.archlinux.org/index.php/Qt#Qt5
# requires: qt5-styleplugins
# TODO: for qt4 -> https://wiki.archlinux.org/index.php/Qt#Qt4
export QT_STYLE_OVERRIDE=gtk2

# see: https://github.com/emersion/xdg-desktop-portal-wlr
# for zoom
export XDG_CURRENT_DESKTOP=sway
