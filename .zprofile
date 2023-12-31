#!/usr/bin/zsh

[[ "$TTY" == /dev/tty* ]] || return 0

export $(systemctl --user show-environment)

export GPG_TTY="$TTY"
# https://wiki.archlinux.org/title/SSH_keys#SSH_agents
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
systemctl --user import-environment GPG_TTY SSH_AUTH_SOCK

# If running from tty1 start wm
if [[ -z $DISPLAY && "$TTY" == "/dev/tty1" ]]; then
  # enable logging and journalctl
  systemd-cat -t hyprland Hyprland
  systemctl --user stop hyprland-session.target
  systemctl --user unset-environment WAYLAND_DISPLAY SWAYSOCK
fi
