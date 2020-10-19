#
# Filetypes
#
hook global BufCreate .*(sway|i3)/(config|[\d\w\s_\-]+)\.conf$ %{
  set buffer filetype i3
}
hook global BufCreate .*waybar/config %{
  set buffer filetype json
}
hook global BufCreate .*\.rasi$ %{
  set buffer filetype json
}

#
# Navigating Files & Buffers
#
define-command files -docstring 'Open one or many files' %{ evaluate-commands %sh{
  FILES=$(rg --files --sort path | rofi -dmenu -i -p "Kakoune →⁮ Files" -multi-select)
  for file in $FILES; do
    printf 'eval -client %%{%s} edit %%{%s}\n' "$kak_client" "$file" | kak -p "$kak_session"
  done
}}

define-command buffers -docstring 'Switch to a buffer' %{ evaluate-commands %sh{
  buf_files=$(echo "$kak_buflist" | awk 'BEGIN{ RS="[[:space:]]" } /^[^*]/{ print }' | sort)
  buf_other=$(echo "$kak_buflist" | awk 'BEGIN{ RS="[[:space:]]" } /^*/{ print }' | sort)

  BUFFER=$(echo "$buf_files $buf_other" |
    awk 'BEGIN{RS="[[:space:]]"} {if(NF>0){print} }' | rofi -dmenu -i -p "Kakoune → *Buffers*")
  [ -n "$BUFFER" ] && echo "eval -client '$kak_client' 'buffer $BUFFER'" | kak -p "$kak_session"
}}
