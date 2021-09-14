#!/usr/bin/zsh

[[ "$TTY" == /dev/tty* ]] || return 0

export $(systemctl --user show-environment)

# If running from tty1 start sway
if [[ -z $DISPLAY && "$TTY" == "/dev/tty1" ]]; then
  # enable logging and journalctl
  systemd-cat --identifier=sway sway
  systemctl --user stop sway-session.target
  systemctl --user unset-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK
fi
