colorscheme gruvbox-nobg

add-highlighter global/ number-lines	-hlcursor -separator " "
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


evaluate-commands %sh{
    # cwd='at {cyan}%sh{ pwd | sed "s|^$HOME|~|" }{default}'
    bufname='{bright-green}%val{bufname}{default}'
    modified='{black,bright-red+b}%sh{ $kak_modified && echo "*" }{default}%sh{ $kak_modified && echo " "}'
    ft='{bright-blue}%sh{ echo "${kak_opt_filetype:-noft}" }{default}'
    eol='%val{opt_eolformat}'
    cursor='%val{cursor_line}{default}:%val{cursor_char_column}{default}'
    readonly='{red+b}%sh{ [ -f "$kak_buffile" ] && [ ! -w "$kak_buffile" ] && echo " " }{default}'
    echo set global modelinefmt "'{{mode_info}} ${bufname} ${readonly}${modified}${ft} ${eol} ${cursor}'"
}
