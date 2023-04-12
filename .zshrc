### Pimpin' aint easy
#
# dircolors & exa
eval $(dircolors $XDG_CONFIG_HOME/LS_COLORS)
rbit="38;5;11"
wbit="38;5;10"
xbit="32"
warnbit="38;5;15;41;1"
sbit="36;1"
rwx_str="ur=${rbit}:gr=${rbit}:tr=${rbit}:uw=${wbit}:gw=${wbit}:tw=${warnbit}:ue=37:ux=${xbit}:gx=${xbit}:tx=${xbit}"
owner="uu=37:gu=37:un=38;5;8:gn=38;5;8"
EXA_COLORS="${rwx_str}:${owner}:su=${sbit}:sf=${sbit}:da=38;5;12:sn=36:sb=1;36"
export EXA_COLORS

# git prompt
source /usr/share/zsh/scripts/git-prompt.zsh
# http://www.unicode-symbol.com/u/E0B0.html 
PROMPT='%K{232}%F{8}%?|%f%F{12}%T%f%F{7} %~%f%F{0} %f%k$(gitprompt)%F{yellow}%(!.%F{red}‼%f.§)%f '

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
alias ls='exa -gF --git --group-directories-first'
alias ll='ls -l'
alias lt='ls --tree'
alias rm='trash-put'
alias vi='vim'
alias hx='helix'
alias renamer='renamer *'
alias less=$PAGER
alias diff='diff --color=auto'
alias ip='ip -color=auto'
alias grep='grep --color=auto'
alias ishrink='convert -resize 1200 -quality 90'
alias o="xdg-open"
alias sudo="sudo -E"
alias ssh="kitty +kitten ssh"
# NOTE: this won't work in kakoune shell, see ~/.local/bin/dots
# alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias conf='/usr/bin/git --git-dir=/.conffiles/ --work-tree=/'

#
# zsh
unsetopt beep

### Auto-complete shit
#
fpath=("$HOME/.local/share/zsh" $fpath)
setopt COMPLETE_ALIASES
autoload -Uz compinit
compinit

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

zstyle ':completion:*'             completer   _complete _ignored
zstyle :compinstall                filename    '${HOME}/.zshrc'
zstyle ':completion:*'             menu        select
zstyle ':completion:*:default'     list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:pacman:*'    force-list  always
zstyle ':completion:*:*:pacman:*'  menu        yes       select
zstyle ':completion:*:*:kill:*'    menu        yes       select
zstyle ':completion:*:kill:*'      force-list  always
zstyle ':completion:*:*:killall:*' menu        yes       select
zstyle ':completion:*:killall:*'   force-list  always

### Key bindings
# NOTE: showkey -a
#
# bindkey -v
bindkey -e
# typeset -g -A key

bindkey '^?'       backward-delete-char             # backspace
bindkey '^[[3~'    delete-char                      # delete

bindkey '^K'       up-line-or-history               # pgup
bindkey '^J'       down-line-or-history             # pgdown
# bindkey '^[[A'     up-line-or-beginning-search      # up
# bindkey '^[[B'     down-line-or-beginning-search    # down
bindkey '^[[D'     backward-char                    # left
bindkey '^[[C'     forward-char                     # right
bindkey '^[[H'     beginning-of-line                # home
bindkey '^[[F'     end-of-line                      # end
bindkey '^H'       backward-word
bindkey '^L'       forward-word
bindkey '^[[Z'     reverse-menu-complete

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

base16_view_colors() {
  x=`tput op`
  y=`printf %5s`
  for i in {0..15}; do
    o=00$i
    echo -e "# "`tput setaf $i`${o:${#o}-3:3}\
    "The $(tput bold)quick brown $(tput sgr0)$(tput setaf $i)fox jumped over the lazy fox 0123456789 () [ ] { } < >"\
    `tput setaf $i;tput setab $i`${y// /=}$x
  done
}

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use # This loads nvm

# Load Angular CLI autocompletion.
source <(ng completion script)
