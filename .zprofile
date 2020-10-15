#!/usr/bin/env zsh
# TODO: why do these have to be sourced here
#

source $HOME/.config/shell/exports.sh

# If running from tty1 start sway
if [ "$(tty)" = "/dev/tty1" ]; then
  # enable logging and journalctl
	exec systemd-cat --identifier=sway sway
fi
