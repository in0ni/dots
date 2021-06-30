# Source a local project kak config if it exists
# Make sure it is set as a kak filetype
hook global BufCreate (.*/)?(\.kakrc) %{
    set-option buffer filetype kak
}
try %{ source .kakrc }

#
# Set custom filetypes for syntax/formatting/linting
#
hook global BufCreate .*(sway|i3)/(config|[\d\w\s_\-]+)\.conf$ %{
  set buffer filetype i3
}
hook global BufCreate .*(dunstrc|pacman\.conf)$ %{
  set buffer filetype ini
}
hook global BufCreate .*(waybar/config|\.rasi)$ %{
  set buffer filetype json
}
hook global BufCreate .*theme/.*\.rasi$ %{
  set buffer filetype css
}

# Searching Files & Buffers w/ rofi
#
define-command files -docstring 'Open one or many files' %{ evaluate-commands %sh{
  # TODO: make this into a function (returns emty string or full option string)
  theme_file="$HOME/.config/rofi/theme/${kak_opt_colorscheme}.rasi"
  rofi_theme_option=""

  if [ -f "${theme_file}" ]; then
    rofi_theme_option="-theme $theme_file"
  else
    echo "fail 'Rofi theme not found: $theme_file'"
  fi

  FILES=$(rg --files --hidden --sort path | rofi -dmenu -i -p "  →⁮ Files" -multi-select $rofi_theme_option)
  for file in $FILES; do
    printf 'eval -client %%{%s} edit %%{%s}\n' "$kak_client" "$file" | kak -p "$kak_session"
  done
}}

define-command buffers -docstring 'Switch to a buffer' %{ evaluate-commands %sh{
  # TODO: make this into a function (returns emty string or full option string)
  theme_file="$HOME/.config/rofi/theme/${kak_opt_colorscheme}.rasi"
  rofi_theme_option=""

  if [ -f "${theme_file}" ]; then
    rofi_theme_option="-theme $theme_file"
  else
    echo "fail 'Rofi theme not found: $theme_file'"
  fi

  buf_files=$(echo "$kak_buflist" | awk 'BEGIN{ RS="[[:space:]]" } /^[^*]/{ print }' | sort)
  buf_other=$(echo "$kak_buflist" | awk 'BEGIN{ RS="[[:space:]]" } /^*/{ print }' | sort)

  BUFFER=$(echo "$buf_files $buf_other" |
    awk 'BEGIN{RS="[[:space:]]"} {if(NF>0){print} }' | rofi -dmenu -i -p "  → *Buffers*" $rofi_theme_option)
  [ -n "$BUFFER" ] && echo "eval -client '$kak_client' 'buffer $BUFFER'" | kak -p "$kak_session"
}}
