colorscheme gruv-light-hard

add-highlighter global/ number-lines	-hlcursor -separator " "
add-highlighter global/ show-matching
add-highlighter global/ wrap			-indent
add-highlighter global/ show-whitespaces
add-highlighter global/ regex \b(TODO|FIXME|XXX|NOTE)\b 0:default+rb

set-option global ui_options	'ncurses_assistant=none' 'ncurses_status_on_top=yes'
set-option global tabstop		4
set-option global indentwidth	2
set-option global scrolloff     4,6

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
    if [ -f "${kak_buffile}" ]; then
      echo "set-option window cursor_percent '$(($kak_cursor_line * 100 / $(wc -l < $kak_buffile)))%'"
    # FIXME: see *debug*
    # else
    #   echo "
    #     eval -save-regs 'm' %{
    #       exec -draft '%<a-s>:reg m %reg{#}<ret>'
    #       set window cursor_percent %sh{echo \$((\$kak_cursor_line * 100 / \$kak_reg_m))}
    #     }
    #   "
    fi
  } }
}

evaluate-commands %sh{:
    pad='{comment}·{default}'
    div='{comment} {default}'
    at='{comment}@{default}'

    bufname='%val{bufname}'
    readonly='{red+b}%sh{ [ -f "$kak_buffile" ] && [ ! -w "$kak_buffile" ] && echo " " }{default}'
    ft='%sh{ echo "${kak_opt_filetype:-noft}" }'
    eol='%val{opt_eolformat}'
    cursor='%val{cursor_line}:%val{cursor_char_column}'
    cursor_percent='{comment}%opt{cursor_percent}{default}'
    client='%val{client}'
    session='%val{session}'

    echo set global modelinefmt "'${bufname} ${readonly}{{mode_info}}${div}${ft}${pad}${eol}${div}${cursor_percent}${div}${cursor}${div}${client}${at}${session} {{context_info}}'"
}
