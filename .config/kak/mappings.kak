alias global g grep
alias global f find

map global normal '#' :comment-line<ret> -docstring 'comment line'
map global normal '<a-#>' :comment-block<ret> -docstring 'comment block'
map global normal '<c-p>' :files<ret> -docstring 'browse files'
map global normal '<c-a-p>' :buffers<ret> -docstring 'browse buffers'
map global normal '<c-w>' :delete-buffer<ret> -docstring 'delete buffer'
map global normal '<minus>' :buffer-previous<ret> -docstring 'previous buffer'
map global normal '<=>' :buffer-next<ret> -docstring 'next buffer'

# lint usermode
declare-user-mode lint
map global lint l ':lint-buffer<ret>' -docstring 'lint buffer'
map global lint n ':lint-next-message<ret>' -docstring 'next message'
map global lint p ':lint-previous-message<ret>' -docstring 'previous message'
map global lint h ':lint-hide-diagnostics<ret>' -docstring 'hide diagnostics'
map global lint s ':lint-selections<ret>' -docstring 'selections'
map global user i ':enter-user-mode lint<ret>' -docstring 'lint mode'

# format usermode
declare-user-mode format
map global format f ':format-buffer<ret>' -docstring 'format buffer'
map global format s ':format-selections<ret>' -docstring 'format selections'
map global user m ':enter-user-mode format<ret>' -docstring 'format mode'

# not managed by plug.kak
map -docstring "lsp mode" global user l ': enter-user-mode lsp<ret>'

# <tab> for both indenting and completions
# see: https://github.com/mawww/kakoune/wiki/Indentation-and-Tabulation
hook global InsertCompletionShow .* %{
  try %{
    # this command temporarily removes cursors preceded by whitespace;
    # if there are no cursors left, it raises an error, does not
    # continue to execute the mapping commands, and the error is eaten
    # by the `try` command so no warning appears.
    execute-keys -draft 'h<a-K>\h<ret>'
    map window insert <tab> <c-n>
    map window insert <s-tab> <c-p>
    hook -once -always window InsertCompletionHide .* %{
      unmap window insert <tab> <c-n>
      unmap window insert <s-tab> <c-p>
    }
  }
}

#
# Vue dynamic comment support
# 
hook global BufCreate .*\.vue %{
  map buffer normal '#' ': eval -itersel %{ set-comments-vue; comment-line; }<ret>'
  map buffer normal '<a-#>' ': eval -itersel %{ set-comments-vue; comment-block; }<ret>'
}

#
# Svelte dynamic comment support
# 
hook global BufCreate .*\.svelte %{
  map buffer normal '#' ': eval -itersel %{ set-comments-svelte; comment-line; }<ret>'
  map buffer normal '<a-#>' ': eval -itersel %{ set-comments-svelte; comment-block; }<ret>'
}

define-command set-comments -params 3 %{
  set-option buffer comment_line %arg{1}
  set-option buffer comment_block_begin %arg{2}
  set-option buffer comment_block_end %arg{3}
}

define-command set-comments-vue %{
  try %{
    # check to see if you are inside a template. if it fails try the next region
    exec -draft '<a-i>c<lt>template.*?<gt>,<lt>/template<gt><ret>'
    set-comments '' '<!--' '--!>'
  } catch %{ try %{
    # check for script tags. sass, scss etc... actually use js style
    exec -draft '<a-i>c<lt>style.*?<gt>,<lt>/style<gt><ret>'
    set-comments '' '/*' '*/'
  } catch %{
    # comment for javascript as the default
    set-comments '//' '/*' '*/'
  }}
}

define-command set-comments-svelte %{
  try %{
    # check to see if you are inside a script tag
    exec -draft '<a-i>c<lt>script.*?<gt>,<lt>/script<gt><ret>'
    set-comments '//' '/*' '*/'
  } catch %{ try %{
    # check for script tags. sass, scss etc... actually use js style
    exec -draft '<a-i>c<lt>style.*?<gt>,<lt>/style<gt><ret>'
    set-comments '' '/*' '*/'
  } catch %{
    # comment for html as the default
    set-comments '' '<!--' '--!>'
  }}
}

