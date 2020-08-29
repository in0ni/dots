# source /usr/share/kak-lsp/rc/lsp.kak
# lsp-enable
# lsp-auto-hover-insert-mode-enable

set-option global grepcmd 'rg --follow --smart-case --with-filename --column'

hook global ModuleLoaded kitty %{
  set-option global kitty_window_type 'os'
}

def ide %{
  rename-client main
  set global jumpclient main

  new rename-client tools
  set global toolsclient tools

  new rename-client docs
  set global docsclient docs
}
