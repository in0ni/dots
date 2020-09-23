#
# Filetypes
#
hook global BufCreate .*(sway|i3)/(config|[\d\w\s_\-]+)\.conf$ %{
  set buffer filetype i3
}
hook global BufCreate .*waybar/config %{
  set buffer filetype json
}

#
# Navigating Files & Buffers
#
define-command files -docstring 'Open one or many files' %{ evaluate-commands %sh{
  FILES=$(rg --files | rofi -dmenu -i -p files -multi-select)
  for file in $FILES; do
    printf 'eval -client %%{%s} edit %%{%s}\n' "$kak_client" "$file" | kak -p "$kak_session"
  done
} }

define-command buffers -docstring 'Switch to a buffer' %{ evaluate-commands %sh{
  BUFFER=$(eval set -- "$kak_buflist"; for buf in "$@"; do echo "$buf"; done | rofi -dmenu -i -p buffers)
  [ -n "$BUFFER" ] && echo "eval -client '$kak_client' 'buffer $BUFFER'" | kak -p "$kak_session"
} }
