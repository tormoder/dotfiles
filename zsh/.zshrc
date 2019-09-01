# path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# custom dir
ZSH_CUSTOM=$HOME/.zsh/oh-my-zsh-custom

# theme
ZSH_THEME="steeef-dark"

# disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# plugins
plugins=(git archlinux ssh-agent golang systemd vundle docker kubectl fzf)

# dircolors
eval $(dircolors -b ~/.dir_colors)

# aliases
alias gotip=$HOME/go-dev/bin/go

# private kubectl aliases
source $HOME/.kubectl_aliases

# init oh-my-zsh
source $ZSH/oh-my-zsh.sh

HISTFILE=~/Dropbox/history/.zsh_history_workstation
HISTSIZE=999999999
SAVEHIST=$HISTSIZE
