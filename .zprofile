#!/usr/bin/zsh

## PATH
export PATH=$HOME/.local/bin:$PATH

## XDG
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

## PREFERENCES
export VISUAL=kak
export EDITOR=kak
export SUDO_EDITOR=kak
export PAGER=vimpager
export MANPAGER=kak-man-pager

## WAYLAND
export MOZ_ENABLE_WAYLAND=1

# see: https://wiki.archlinux.org/index.php/Qt#Qt5
# TODO: for qt4 -> https://wiki.archlinux.org/index.php/Qt#Qt4
# requires: qt5-styleplugins
export QT_QPA_PLATFORMTHEME=gtk2
# see: https://github.com/emersion/xdg-desktop-portal-wlr
export XDG_CURRENT_DESKTOP=sway
# https://github.com/systemd/systemd/issues/14489
export XDG_SESSION_TYPE=wayland
# https://wiki.archlinux.org/index.php/Uniform_look_for_Qt_and_GTK_applications#Using_a_GTK_icon_theme_in_Qt_apps
export DESKTOP_SESSION=gnome

# If running from tty1 start sway
if [ "$(tty)" = "/dev/tty1" ]; then
  # enable logging and journalctl
  exec systemd-cat --identifier=sway sway
  # TODO: on sway exit, should stop sway-session.taget -- unable to here
fi
