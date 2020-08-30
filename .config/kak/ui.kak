colorscheme gruv-light-hard

add-highlighter global/ number-lines	-hlcursor -separator ""
add-highlighter global/ show-matching
add-highlighter global/ wrap			-indent
add-highlighter global/ show-whitespaces

set-option global ui_options	'ncurses_assistant=none' 'ncurses_status_on_top=yes'
set-option global tabstop		4
set-option global indentwidth	2

# update clipboard whenever you yank, delete, change, or  update the default change register (")
hook global RegisterModified '"' %{ nop %sh{
  printf %s "$kak_main_reg_dquote" | wl-copy > /dev/null 2>&1 &
}}

def ide -docstring 'open 3 client windows: main, docs, tools'%{
  rename-client main
  set global jumpclient main

  new rename-client tools
  set global toolsclient tools

  new rename-client docs
  set global docsclient docs
}

evaluate-commands %sh{:
    pad='{value}·{default}'
    div='{comment}  {default}'
    at='{comment}@{default}'

    bufname='%val{bufname}'
    readonly='{red+b}%sh{ [ -f "$kak_buffile" ] && [ ! -w "$kak_buffile" ] && echo " " }{default}'
    ft='%sh{ echo "${kak_opt_filetype:-noft}" }'
    eol='%val{opt_eolformat}'
    cursor='%val{cursor_line}:%val{cursor_char_column}'
    client='%val{client}'
    session='%val{session}'

    echo set global modelinefmt "'${bufname} ${readonly}{{mode_info}}${div}${ft}${pad}${eol}${pad}${cursor}${div}${client}${at}${session} {{context_info}}'"
}
