map global normal '#' :comment-line<ret> -docstring 'comment line'
map global normal '<a-#>' :comment-block<ret> -docstring 'comment block'
map global normal '<c-p>' :files<ret> -docstring 'browse files'
map global normal '<c-a-p>' :buffers<ret> -docstring 'browse buffers'
map global normal '<c-w>' :delete-buffer<ret> -docstring 'delete buffer'
map global normal '<minus>' :buffer-previous<ret> -docstring 'previous buffer'
map global normal '<=>' :buffer-next<ret> -docstring 'next buffer'

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
  }
}

hook global InsertCompletionHide .* %{
  unmap window insert <tab> <c-n>
  unmap window insert <s-tab> <c-p>
}

#
# Vue dynamic comment support
# 
hook global BufCreate .*\.vue %{
  map buffer normal '#' ': eval -itersel %{ set-comments-vue; comment-line; }<ret>'
  map buffer normal '<a-#>' ': eval -itersel %{ set-comments-vue; comment-block; }<ret>'
}

define-command set-comments -params 3 %{
  set-option buffer comment_line %arg{1}
  set-option buffer comment_block_begin %arg{2}
  set-option buffer comment_block_end %arg{3}
}

define-command set-comments-vue %{
  try %{
    # check to see if you are inside a template. if it fails try the next region
    exec -draft '<a-i>c<template.*?>,</template>'
    set-comments '' '<!--' '--!>'
  } catch %{ try %{
    # check for script tags. sass, scss etc... actually use js style
    exec -draft '<a-i>c<style.*?>,</style>'
    set-comments '' '/*' '*/'
  } catch %{
    # comment for javascript as the default
    set-comments '//' '/*' '*/'
  }}
}

#
