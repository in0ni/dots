hook global WinSetOption filetype=(javascript|json|python|svelte|php|html|css|scss|less) %{
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
hook global WinSetOption filetype=(javascript|typescript|css|scss|less|json|markdown|yaml|html|vue|twig|svelte) %{
  set-option buffer formatcmd "npx --no-install prettier --stdin-filepath=%val{buffile}"
  enable-autoformat
}

hook global WinSetOption filetype=(css|scss|less) %{
  set-option window lintcmd 'run() { cat "$1" | npx --no-install stylelint --formatter unix --stdin-filename="$kak_buffile";} && run'
  enable-autolint
}

hook global WinSetOption filetype=(javascript|svelte) %{
  set-option window lintcmd 'run() { cat "$1" | npx --no-install eslint -f unix --stdin --stdin-filename "$kak_buffile";} && run'
  enable-autolint
}

# hook global WinSetOption filetype=(twig) %{
#   set-option window lintcmd 'run() { cat "$1" | twigcs -r emacs "$kak_buffile" | sed -E "s/: (\w+) - /: \1: /g";} && run'
#   enable-autolint
# }

hook global WinSetOption filetype=json %{
  # formatting done w/ prettier above
  set-option window lintcmd %{ run() { cat -- "$1" | jq 2>&1 | awk -v filename="$1" '/ at line [0-9]+, column [0-9]+$/ { line=$(NF - 2); column=$NF; sub(/ at line [0-9]+, column [0-9]+$/, ""); printf "%s:%d:%d: error: %s", filename, line, column, $0; }'; } && run }
  enable-autolint
}

hook global WinSetOption filetype=python %{
  hook global ModuleLoaded smarttab %{
    set-option global softtabstop 4
  }

  set-option buffer indentwidth 4
  set-option window lintcmd "flake8 --filename='*' --format='%%(path)s:%%(row)d:%%(col)d: error: %%(text)s' --ignore=E121,E123,E126,E226,E24,E704,W503,W504,E501,E221,E127,E128,E129,F405"
  set-option buffer formatcmd "black -"
  enable-autoformat
  enable-autolint
}

hook global WinSetOption filetype=sh %{
  set-option window lintcmd "shellcheck -x -fgcc -Cnever"
  set-option buffer formatcmd "shfmt -i %opt{indentwidth} -ci -bn -sr"
  enable-autolint
  enable-autoformat
}

hook global WinSetOption filetype=php %{
  set-option window lintcmd 'run() { cat "$1" | phpcs --report="emacs" --stdin-path="$kak_buffile" - | sed "s/ - /: /" ; } && run'
  set-option buffer formatcmd 'phpcbf -q --stdin-path="$kak_buffile" - || true'
  enable-autoformat
  enable-autolint
}
