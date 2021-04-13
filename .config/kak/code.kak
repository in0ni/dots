eval %sh{kak-lsp --kakoune -s $kak_session}  # Not needed if you load it with plug.kak.
hook global WinSetOption filetype=(javascript) %{
  lsp-enable-window
}
def -hidden insert-c-n %{
  try %{
    snippets-select-next-placeholders
    exec '<a-;>d'
  } catch %{
    exec -with-hooks '<c-n>'
  }
}
map global insert <c-n> "<a-;>: insert-c-n<ret>"
map global insert <c-s> '<a-;>: snippets '

# source /usr/share/kak-lsp/rc/lsp.kak
# lsp-enable
# lsp-auto-hover-insert-mode-enable

#
# Hooks
#
# NOTE: if editorconfig is not found, an error is thrown, which is fine
# TODO: only run git commands if inside git dir: "git rev-parse --is-inside-work-tree"
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
  evaluate-commands %sh{
    if [ "$kak_opt_autofmt" == "true" ]; then
      echo "enable-autoformat"
    fi
  }
}

hook global WinSetOption filetype=(css|scss) %{
  set-option window lintcmd "npx stylelint --fix --stdin-filename='%val{buffile}'"
  evaluate-commands %sh{
    if [ "$kak_opt_autolint" == "true" ]; then
      echo "enable-autolint"
    fi
  }
}

hook global WinSetOption filetype=(javascript|html) %{
  set window lintcmd 'npx eslint --config .eslintrc.js --format=node_modules/eslint-formatter-kakoune'
  evaluate-commands %sh{
    if [ "$kak_opt_autolint" == "true" ]; then
      echo "enable-autolint"
    fi
  }
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
