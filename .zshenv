export $(envsubst <$HOME/.config/environment.d/01-path.conf)
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

export LANG=en_US.UTF-8
export LANGUAGE=en_US

export EDITOR=helix
export VISUAL=$EDITOR
export SUDO_EDITOR=$EDITOR
export GIT_EDITOR=$EDITOR
export PAGER='bat -p'
