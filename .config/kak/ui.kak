# Source a local project kak config if it exists
# Make sure it is set as a kak filetype
hook global BufCreate (.*/)?(\.kakrc) %{
    set-option buffer filetype kak
}
try %{ source .kakrc }

hook global WinCreate .* %{ try %{
  add-highlighter buffer/numbers number-lines -hlcursor -separator ' '
  add-highlighter buffer/matching show-matching
  add-highlighter buffer/wrap wrap -word -indent
  add-highlighter buffer/whitespaces show-whitespaces -spc ' ' -lf ' ' -nbsp '·'

  # TODO: apply only to js?
  add-highlighter buffer/jsdoc regex \*\s+(@\b[\w\-]+)\b 0:default 1:default+ab
  add-highlighter buffer/jsdoctodo regex @\b(todo)\b 0:default 1:default+abrd

  add-highlighter buffer/todo regex \b(TODO|NOTE|SEE)\b 0:default+ard
  add-highlighter buffer/fix regex \b(FIXME|XXX)\b 0:default+arb
}}

set-option global ui_options 'terminal_assistant=none' 'terminal_status_on_top=yes'
set-option global autoreload yes
set-option global tabstop 4
set-option global indentwidth 2
set-option global scrolloff 3,6

set-option global grepcmd 'rg --follow --with-filename --column'
# set-option global lsp_auto_highlight_references true

hook global ModuleLoaded kitty %{ set-option global kitty_window_type 'os' }

# paste with middle mouse button
# hook global RawKey <mouse:press:middle:.*> %{ evaluate-commands exec wl-paste<space>-p<ret> }

# update clipboard whenever you yank, delete, change, or  update the default change register (")
hook global RegisterModified '"' %{ nop %sh{
  printf %s "$kak_main_reg_dquote" | wl-copy > /dev/null 2>&1 &
}}

# position in file as percent
decl str cursor_percent
hook global WinCreate .* %{
  hook window NormalIdle .* %{ evaluate-commands %sh{
    echo "set-option window cursor_percent '$(($kak_cursor_line * 100 / $kak_buf_line_count))'"
  } }
}

evaluate-commands %sh{:
    pad='{comment}·{default}'
    div='{comment} {default}'
    at='{comment}@'

    bufname='%val{bufname}'
    readonly='{red+b}%sh{ [ -f "$kak_buffile" ] && [ ! -w "$kak_buffile" ] && echo " " }{default}'
    ft='{function}%sh{ echo "${kak_opt_filetype:-noft}" }'
    eol='{comment}%val{opt_eolformat}'
    cursor='%val{cursor_line}:%val{cursor_char_column}'
    cursor_percent='{value}%opt{cursor_percent}·'
    client='%val{client}'
    session='%val{session}'

    echo set global modelinefmt "'${bufname} ${readonly}{{mode_info}}${div}${ft}${pad}${eol}${div}${cursor_percent}${cursor}${div}${client}${at}${session} {{context_info}}'"
}

# set theme variant according to time period
evaluate-commands %sh{
  theme=$(waystep kak)
  echo "cs $theme"
}
