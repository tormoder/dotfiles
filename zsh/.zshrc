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

# init oh-my-zsh
source $ZSH/oh-my-zsh.sh

HISTFILE=~/.zsh_history_archvm
HISTSIZE=999999999
SAVEHIST=$HISTSIZE
