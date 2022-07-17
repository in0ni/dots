define-command new-tab -params .. -docstring '
new [<commands>]: create a new Kakoune client
The ''terminal'' alias is being used to determine the user''s preferred terminal emulator
The optional arguments are passed as commands to the new client' \
%{
    terminal-tab kak -c %val{session} -e "%arg{@}"
}

define-command ide-focus -params 1 -client-completion -docstring '
ide-focus [<client>]: focus the given client
If no client is passed then the current one is used' %{
  nop %sh{
    swaymsg "[con_mark=\"${kak_session}::${1}\"] focus"
  }
}

define-command write-close -docstring '
write-close: write and close current buffer' %{
  write
  delete-buffer
}

define-command write-close-force -docstring '
write-close-force: write! & delete-buffer!' %{
  write!
  delete-buffer!
}

define-command write-all-kill -params 0 -docstring '
write-all-kill: write all buffers and kill current session' %{
  write-all
  kill
}

# TODO: create PR for kakoune
define-command kitty-terminal-overlay -params 1.. -shell-completion -docstring '
kitty-terminal-overlay <program> [<arguments>]: create a new terminal as overlay
The program passed as argument will be executed in the new overlay' %{
  nop %sh{
    match=""
    if [ -n "$kak_client_env_KITTY_WINDOW_ID" ]; then
      match="--match=id:$kak_client_env_KITTY_WINDOW_ID"
    fi

    listen=""
    if [ -n "$kak_client_env_KITTY_LISTEN_ON" ]; then
      listen="--to=$kak_client_env_KITTY_LISTEN_ON"
    fi

    kitty @ $listen launch --no-response --type=overlay --cwd="$PWD" $match "$@"
  }
}

require-module kitty
alias global focus ide-focus
