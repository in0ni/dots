### Pimpin' aint easy
# NOTE: using custom "base16" colors in kity term,
#       using lscolors-git (/etc/profile), keeping my version separate
#
eval $(dircolors $HOME/.dir_colors)
PROMPT='%K{black}%F{35}%T%f%k%K{236} %F{12}%~%f %k%F{blue}%(!.%F{red}#%f.$)%f '

### History
#
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups   # Collapse two consecutive idential commands.
setopt hist_find_no_dups  # Ignore duplicates when searching history.
setopt share_history      # Read lines other shells write too.
setopt hist_ignore_space  # Lines that begin with space are not recorded.
setopt hist_verify        # Don't auto-execute selected history entry.

### Aliases
#
alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias vi='nvim'
alias ls='ls -hN --color=auto'
alias ll='ls -l'
alias less=$PAGER
alias ip='ip -color=auto'
alias diff='colordiff'
alias kdiff='kitty +kitten diff'
alias grep='grep --color=auto'

# safety features
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# error tolerant
alias :q=' exit'
alias :Q=' exit'
alias :x=' exit'

### Key bindings
# NOTE: showkey -a
#
typeset -g -A key
#bindkey -v
bindkey -e
bindkey '^[[3~' delete-char           # delete
bindkey '^?'    backward-delete-char     # backspace
bindkey '^[[5~' up-line-or-history    # pgup
bindkey '^[[3~' delete-char           # delete
bindkey '^[[6~' down-line-or-history  # pgdown
bindkey '^[[A'  up-line-or-search      # up
bindkey '^[[B'  down-line-or-search    # down
bindkey '^[[D'  backward-char          # left
bindkey '^[[C'  forward-char           # right
bindkey '^[[H'  beginning-of-line      # home
bindkey '^[[F'  end-of-line            # end

# zsh
setopt extendedglob nomatch notify
unsetopt beep

### Auto-complete shit
#
setopt COMPLETE_ALIASES
autoload -Uz compinit
compinit

zstyle :compinstall filename '${HOME}/.zshrc'
zstyle ':completion:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*:pacman:*' force-list always
zstyle ':completion:*:*:pacman:*' menu yes select
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always
zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*'   force-list always

### Colored man pages
#
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

### Titles
#
case $TERM in
  termite|*xterm*|rxvt|rxvt-unicode|rxvt-256color|rxvt-unicode-256color|(dt|k|E)term)
    precmd () {
      print -Pn "\e]0;%~\a"
    } 
    preexec () { print -Pn "\e]0;%~ ($1)\a" }
    ;;
  screen|screen-256color)
    precmd () { 
      print -Pn "\e]83;title \"$1\"\a" 
      print -Pn "\e]0;$TERM - (%L) [%n@%M]%# %~\a" 
    }
    preexec () { 
      print -Pn "\e]83;title \"$1\"\a" 
      print -Pn "\e]0;$TERM - (%L) [%n@%M]%# %~ ($1)\a" 
    }
    ;; 
esac

### Sourced
# NOTE: recommended by zsh-syntax-highlighting that this be at the end,
#       so moving both here
# 
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# fzf
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
