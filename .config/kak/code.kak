# source /usr/share/kak-lsp/rc/lsp.kak
# lsp-enable
# lsp-auto-hover-insert-mode-enable

set-option global grepcmd 'rg --follow --smart-case --with-filename --column'

define-command disable-autoformat -docstring 'disable auto-format' %{
  unset-option buffer formatcmd
  remove-hooks buffer format
}

define-command disable-autolint -docstring 'disable auto-lint' %{
  lint-hide-diagnostics
  unset-option buffer lintcmd
  remove-hooks buffer lint
}

#
# Hooks
#
# NOTE: if editorconfig is not found, an error is thrown, which is fine
hook global WinCreate ^[^*]+$ %{ editorconfig-load }
hook global BufWritePost ^[^*]+$ %{ git show-diff }
hook global BufReload ^[^*]+$ %{ git show-diff }

#
# Format & Lint
#

# NOTE: npx usage -- if tools are not installed (in local project or globally) it will be
#       temporarily downloaded. Best to *always* have installed locally.
hook global BufSetOption filetype=(javascript|typescript|css|scss|json|markdown|yaml|html|vue) %{
  set-option buffer formatcmd "npx prettier --stdin-filepath=%val{buffile}"
  hook buffer -group format BufWritePre .* format
}

hook global WinSetOption filetype=(vue|css) %{
  set-option window lintcmd "npx stylelint --fix --stdin-filename='%val{buffile}'"
  hook buffer -group lint BufWritePost .* lint
}

hook global WinSetOption filetype=(javascript|html|vue) %{
  set window lintcmd 'npx eslint --config .eslintrc.js --format=node_modules/eslint-formatter-kakoune'
  hook buffer -group lint BufWritePost .* lint
}
