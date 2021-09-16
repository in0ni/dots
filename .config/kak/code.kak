#
# lsp
#
eval %sh{kak-lsp --kakoune -s $kak_session}  # Not needed if you load it with plug.kak.
hook global WinSetOption filetype=(javascript|python) %{
  lsp-enable-window
}
# TODO: these commands to enable/disable auto-(lint|format) should only be available
# if the file format supports it -- look into this below
define-command enable-autoformat -docstring 'enable auto-format' %{
  hook buffer -group format BufWritePre .* format
}
define-command disable-autoformat -docstring 'disable auto-format' %{
  unset-option buffer formatcmd
  remove-hooks buffer format
}

define-command enable-autolint -docstring 'enable auto-lint' %{
  hook buffer -group lint BufWritePost .* lint
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
# TODO: only run git commands if inside git dir: "git rev-parse --is-inside-work-tree"
hook global BufOpenFile  .* %{ modeline-parse }
hook global BufOpenFile  .* %{ editorconfig-load }
hook global BufNewFile   .* %{ editorconfig-load }
hook global BufWritePost .* %{ git show-diff }
hook global BufReload    .* %{ git show-diff }

hook global WinSetOption filetype=.* %{
  disable-autoformat
  disable-autolint
}

hook global WinSetOption filetype=man %{
  remove-highlighter buffer/numbers
}

#
# Format & Lint
#

# NOTE: npx usage -- if tools are not installed (in local project or globally) it will be
#       temporarily downloaded. Best to *always* have installed locally.
hook global WinSetOption filetype=(javascript|typescript|css|scss|json|markdown|yaml|html|vue) %{
  set-option buffer formatcmd "npx prettier --stdin-filepath=%val{buffile}"
  enable-autoformat
}

hook global WinSetOption filetype=(css|scss) %{
  set-option window lintcmd "npx stylelint --fix --stdin-filename='%val{buffile}'"
  enable-autolint
}

hook global WinSetOption filetype=(javascript|html) %{
  set-option window lintcmd 'npx eslint --config .eslintrc.js --format=node_modules/eslint-formatter-kakoune'
  enable-autolint
}

hook global WinSetOption filetype=python %{
  hook global ModuleLoaded smarttab %{
    set-option global softtabstop 4
  }

  set-option buffer indentwidth 4
  set-option buffer lsp_server_configuration pyls.configurationSources=["flake8"]
  jedi-enable-autocomplete

  set-option window lintcmd "flake8 --filename='*' --format='%%(path)s:%%(row)d:%%(col)d: error: %%(text)s' --ignore=E121,E123,E126,E226,E24,E704,W503,W504,E501,E221,E127,E128,E129,F405"
  set-option window formatcmd "black -"
  enable-autoformat
  enable-autolint
}

hook global WinSetOption filetype=sh %{
  set-option window lintcmd "shellcheck -fgcc -Cnever"
  enable-autolint
}
