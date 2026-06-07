[[ "$TTY" == /dev/tty* ]] || return 0

while IFS= read -r _line; do export "$_line"; done < <(systemctl --user show-environment)
unset _line

# https://wiki.archlinux.org/title/SSH_keys#SSH_agents
# [[ -S "$XDG_RUNTIME_DIR/ssh-agent.socket" ]] && export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export GPG_TTY="$TTY"
systemctl --user import-environment GPG_TTY # SSH_AUTH_SOCK

# If running from tty1 start wm
if [[ -z $DISPLAY && "$TTY" == "/dev/tty1" ]]; then
  if [[ "$(hostnamectl hostname)" == mc-* ]] && [[ -x /usr/local/bin/tui-session-picker ]]; then
    exec /usr/local/bin/tui-session-picker
  else
    exec systemd-cat -t hyprland start-hyprland
  fi
fi
