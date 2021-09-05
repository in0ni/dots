# Universal options
set-face global Search +bu
add-highlighter global/ show-matching
add-highlighter global/ wrap -indent
add-highlighter global/ show-whitespaces -spc ' ' -lf ' ' -nbsp '·'
# TODO: apply only to js?
add-highlighter global/ regex \*\s+(@\b[\w\-]+)\b 0:default 1:default+ab
add-highlighter global/ regex @\b(todo)\b 0:default 1:default+abrd

add-highlighter global/ regex \b(TODO|NOTE|SEE)\b 0:default+ard
add-highlighter global/ regex \b(FIXME|XXX)\b 0:default+arb

# generally we always want numbers, but not for man pages
# TODO: look into for pagers?
add-highlighter global/ number-lines -hlcursor -separator '⎸'
hook global WinSetOption filetype=man %{
  remove-highlighter global/number-lines_-hlcursor_-separator_⎸ 
}

# set-option global fzf_terminal_command 'kitty-terminal-overlay kak -c %val{session} -e "%arg{@}"'
set-option global ui_options 'terminal_assistant=none' 'terminal_status_on_top=yes'
set-option global tabstop 4
set-option global indentwidth 2
set-option global scrolloff 4,6
set-option global grepcmd 'rg --follow --with-filename --column'

alias global g grep
alias global f find

# paste with middle mouse button
# hook global RawKey <mouse:press:middle:.*> %{ evaluate-commands exec wl-paste<space>-p<ret> }

# update clipboard whenever you yank, delete, change, or  update the default change register (")
hook global RegisterModified '"' %{ nop %sh{
  printf %s "$kak_main_reg_dquote" | wl-copy > /dev/null 2>&1 &
}}

hook global ModuleLoaded kitty %{
  set-option global kitty_window_type 'os'
}

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
