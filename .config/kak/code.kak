source /usr/share/kak-lsp/rc/lsp.kak
lsp-enable
lsp-auto-hover-insert-mode-enable

set-option global grepcmd 'rg --follow --smart-case --with-filename --column'

define-command disable-autoformat -docstring 'disable auto-format' %{
  unset-option buffer formatcmd
  remove-hooks buffer format
}
hook global ModuleLoaded kitty %{
  set-option global kitty_window_type 'os'
}

# hook global WinCreate ^[^*]+$	%{editorconfig-load}
hook global BufWritePost ^[^*]+$ %{ git show-diff }
hook global BufReload ^[^*]+$ %{ git show-diff }

hook global BufSetOption filetype=(javascript|typescript|css|scss|json|markdown|yaml|html) %{
  set-option buffer formatcmd "npx prettier --stdin-filepath=%val{buffile}"
  hook buffer -group format BufWritePre .* format
}

hook global WinSetOption filetype=css %{
  set-option window lintcmd "npx stylelint --fix --stdin-filename='%val{buffile}'"
}

hook global WinSetOption filetype=(javascript|html) %{
  set buffer lintcmd 'npx eslint --format=/usr/lib/node_modules/eslint-formatter-kakoune'
}
