### Pimpin' aint easy
#
eval $(dircolors $XDG_CONFIG_HOME/LS_COLORS)
# git prompt
source /usr/share/zsh/scripts/git-prompt.zsh
export EXA_COLORS="ur=33:uw=31:ux=32:ue=32:di=34:da=38;5;21:sn=36:sb=1;36:uu=37:gu=37:un=38;5;20:gn=38;5;20"
# http://www.unicode-symbol.com/u/E0B0.html 
PROMPT='%K{234}%F{cyan}%T%f %F{blue}%~%f%F{black}%f%k$(gitprompt)%F{yellow}%(!.%F{red}‼%f.§)%f '

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
alias ls='exa -gF --git --group-directories-first'
alias ll='ls -lF'
alias lt='ls --tree'
alias vi='vim'
alias less=$PAGER
alias diff='diff --color=auto'
alias ip='ip -color=auto'
alias grep='grep --color=auto'
alias ishrink='convert -resize 1200 -quality 90'
alias o="xdg-open"
alias sudo="sudo -E"

#
# zsh
unsetopt beep

### Auto-complete shit
#
setopt COMPLETE_ALIASES
zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '${HOME}/.zshrc'

autoload -Uz compinit
compinit

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# zstyle ':completion:*' menu select
# zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# zstyle ':completion:*:pacman:*' force-list always
# zstyle ':completion:*:*:pacman:*' menu yes select
# zstyle ':completion:*:*:kill:*' menu yes select
# zstyle ':completion:*:kill:*'   force-list always
# zstyle ':completion:*:*:killall:*' menu yes select
# zstyle ':completion:*:killall:*'   force-list always

### Key bindings
# NOTE: showkey -a
#
# bindkey -v
bindkey -e
# typeset -g -A key

bindkey '^[[3~'   delete-char                      # delete
bindkey '^?'      backward-delete-char             # backspace
bindkey '^[[5~'   up-line-or-history               # pgup
bindkey '^[[3~'   delete-char                      # delete
bindkey '^[[6~'   down-line-or-history             # pgdown
bindkey '^[[A'    up-line-or-beginning-search      # up
bindkey '^[[B'    down-line-or-beginning-search    # down
bindkey '^[[D'    backward-char                    # left
bindkey '^[[C'    forward-char                     # right
bindkey '^[[H'    beginning-of-line                # home
bindkey '^[[F'    end-of-line                      # end
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

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

term_colors() {
  x=`tput op`
  y=`printf %5s`
  for i in {0..21}; do
    o=00$i
    echo -e `tput setaf $i`${o:${#o}-3:3}\
    "The $(tput bold)quick brown $(tput sgr0)$(tput setaf $i)fox jumped over the lazy fox 0123456789 () [ ] { } < >"\
    `tput setaf $i;tput setab $i`${y// /=}$x
  done
}
