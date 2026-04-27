[[ "$TTY" == /dev/tty* ]] || return 0

while IFS= read -r _line; do export "$_line"; done < <(systemctl --user show-environment)
unset _line

export GPG_TTY="$TTY"
# https://wiki.archlinux.org/title/SSH_keys#SSH_agents
[[ -S "$XDG_RUNTIME_DIR/ssh-agent.socket" ]] && export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
systemctl --user import-environment GPG_TTY SSH_AUTH_SOCK

# If running from tty1 start wm
if [[ -z $DISPLAY && "$TTY" == "/dev/tty1" ]]; then
  exec systemd-cat -t hyprland start-hyprland
fi
