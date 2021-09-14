define-command ide-focus -params 1 -client-completion -docstring '
ide-focus [<client>]: focus the given client
If no client is passed then the current one is used' \
%{
  nop %sh{
    swaymsg "[con_mark=\"${kak_session}::${1}\"] focus"
  }
}

# TODO: create PR for kakoune
define-command kitty-terminal-overlay -params 1.. -shell-completion -docstring '
kitty-terminal-overlay <program> [<arguments>]: create a new terminal as overlay
The program passed as argument will be executed in the new overlay' \
%{
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
