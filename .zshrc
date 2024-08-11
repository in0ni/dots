### Pimpin' aint easy
#
LS_COLORS=$(vivid generate vibra16)
export LS_COLORS

# eza
# https://en.wikipedia.org/wiki/ANSI_escape_code#SGR_(Select_Graphic_Rendition)_parameters
# man eza_colors
rbit="38;5;11"
wbit=$rbit
xbit="38;5;10"
warnbit="38;5;232;41;1"
sbit="36;1"
rwx_str="ur=${rbit}:gr=${rbit}:tr=${rbit}:uw=${wbit}:gw=${wbit}:tw=${warnbit}:ue=37:ux=${xbit}:gx=${xbit}:tx=${xbit}"
owner="uu=38;5;8:gu=38;5;8:un=38;5;8:gn=38;5;8"
# da - date, sn - size number
EZA_COLORS="${rwx_str}:${owner}:su=${sbit}:sf=${sbit}:da=38;5;12:sn=38;5;14;5;12:sb=1;36"
export EZA_COLORS

# fzf
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:8,fg+:7,bg:-1,bg+:0
  --color=hl:14,hl+:14,info:8,marker:10
  --color=prompt:6,spinner:14,pointer:1,header:#87afaf
  --color=border:8,query:-1
  --border="none" --preview-window="border-rounded" --prompt="> "
  --marker="▹" --separator="─" --scrollbar="│" --layout=reverse'

# git prompt
source /usr/share/zsh/scripts/git-prompt.zsh
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg[magenta]%}"
# http://www.unicode-symbol.com/u/E0B0.html 

# zsh prompt
ssh=""
if [[ ${SSH_TTY} ]]; then
  ssh="%F{8}%n%f%F{yellow}@%m%f "
fi
PROMPT='%K{0}$ssh%F{8}%?|%f%F{12}%T%f%F{7} %~%f%F{232} %f%k$(gitprompt)%F{yellow}%(!.%F{red}‼%f.§)%f '

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

# disks
command -v dfrs      &> /dev/null && alias df='dfrs'
command -v dua       &> /dev/null && alias du='dua'
command -v dua       &> /dev/null && alias dui='dua interactive'

# search
command -v fd        &> /dev/null && alias fd='fd --hidden --follow'                            || alias fd='find . -name'
command -v rg        &> /dev/null && alias rg='rg --hidden --follow --smart-case 2>/dev/null'   || alias rg='grep --color=auto --exclude-dir=.git -R'

# ls
command -v eza       &> /dev/null && alias ls='eza -gF --git --group-directories-first'         || alias ls='ls --color=auto --group-directories-first -h'
command -v eza       &> /dev/null && alias la='ll -a'                                           || alias la='ll -A'
command -v eza       &> /dev/null && alias lk='ll -s=size'                                      || alias lk='ll -r --sort=size'
command -v eza       &> /dev/null && alias lm='ll -s=modified'                                  || alias lm='ll -r --sort=time'

# editor
command -v helix     &> /dev/null && alias vi='helix'                                           || alias vi='vim'
command -v helix     &> /dev/null && alias hx='helix'

# misc
command -v batman    &> /dev/null && alias man='batman'
command -v trash-put &> /dev/null && alias rm='trash-put'
command -v gitui     &> /dev/null && alias gu='gitui'
# command -v xplr      &> /dev/null    && alias cdx='cd "$(xplr --print-pwd-as-result)"'

alias o="xdg-open"
alias ll='ls -l'
alias lt='ls --tree'
alias ip='ip -color=auto'
alias renamer='renamer *'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias less=$PAGER
alias ishrink='convert -resize 1200 -quality 90'
alias sudo='sudo -E '
alias ssh='kitty +kitten ssh'
alias dots='/usr/bin/git --git-dir=$HOME/.dots-home/ --work-tree=$HOME'
alias conf='/usr/bin/git --git-dir=$HOME/.dots-root/ --work-tree=/'

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

### Sourced
# NOTE: recommended by zsh-syntax-highlighting that this be at the end,
#       so moving both here
# 
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# fzf
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# simple fn to print current base16 colors
b16_print_colors() {
  bold=$(tput bold)
  reset=$(tput sgr0)
  numbers=({0..15} 231 232)
  for num in "${numbers[@]}"; do
    o=00$num
    setaf=$(tput setaf "$num")
    setab=$(tput setab "$num")
    echo -e "#${o:${#o}-3:3} $setaf"\
    "The ${bold}quick brown ${reset}${setaf}fox jumped over the lazy fox 0123456789 () [ ] { } < >"\
    "$setab     $reset"
  done
}

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use # This loads nvm
