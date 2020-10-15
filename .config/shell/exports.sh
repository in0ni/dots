export PATH=$HOME/.local/bin:$PATH

export VISUAL=kak
export EDITOR=kak
export SUDO_EDITOR=kak
export PAGER=vimpager
export MANPAGER=kak-man-pager

# firefox on wayland
export MOZ_ENABLE_WAYLAND=1

# WebRender support: https://wiki.archlinux.org/index.php/Firefox/Tweaks#Enable_WebRender_compositor
# due to issues w/ gifs on whatsapp, and video (both w/ greenbackgounds, flickering)
# opting for OpenGl compositor instead
# export MOZ_WEBRENDER=1

# https://github.com/systemd/systemd/issues/14489
export XDG_SESSION_TYPE=wayland

# gtk icon theme in qt
# https://wiki.archlinux.org/index.php/Uniform_look_for_Qt_and_GTK_applications#Using_a_GTK_icon_theme_in_Qt_apps
export DESKTOP_SESSION=gnome
# 
# see: https://github.com/emersion/xdg-desktop-portal-wlr
# for zoom
export XDG_CURRENT_DESKTOP=sway

# see: https://wiki.archlinux.org/index.php/Qt#Qt5
# TODO: for qt4 -> https://wiki.archlinux.org/index.php/Qt#Qt4
# requires: qt5-styleplugins
export QT_QPA_PLATFORMTHEME=gtk2
