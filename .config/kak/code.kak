# source /usr/share/kak-lsp/rc/lsp.kak
# lsp-enable
# lsp-auto-hover-insert-mode-enable

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
}

hook global WinSetOption filetype=(vue|css) %{
  set-option window lintcmd "npx stylelint --fix --stdin-filename='%val{buffile}'"
}

hook global WinSetOption filetype=(javascript|html|vue) %{
  set window lintcmd 'npx eslint --config .eslintrc.js --format=node_modules/eslint-formatter-kakoune'
}

# TODO: these commands to enable/disable auto-(lint|format) should only be available
# if the file format supports it -- look into this below
define-command enable-autoformat -docstring 'enable auto-format' %{
  hook buffer -group format BufWritePre .* format
}
define-command disable-autoformat -docstring 'disable auto-format' %{
  remove-hooks buffer format
}

define-command enable-autolint -docstring 'enable auto-lint' %{
  hook buffer -group lint BufWritePost .* lint
}
define-command disable-autolint -docstring 'disable auto-lint' %{
  lint-hide-diagnostics
  remove-hooks buffer lint
}
