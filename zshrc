# Path to your oh-my-zsh configuration.
ZSH=$HOME/.zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(aws brew colorize django docker docker-compose git git-extras gitfast git-flow github git-remote-branch gradle history kubectl mercurial mvn node npm python pylint ssh-agent themes tmux vagrant vim-interaction)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

# Vim config
export MYVIMRC=~/.vimrc

# Tmux config
export TERM="screen-256color-bce"
alias tmux="TERM=screen-256color-bce tmux -u"

alias pdb="python -m pdb"

export PATH=/usr/local/sbin:$PATH
export PATH=$PATH:~/dotfiles/bin

# Anyenv config
export PATH=~/.anyenv/bin:$PATH
eval "$(anyenv init -)"

# Jenv config
eval "$(jenv init -)"

# Pyenv config
eval "$(pyenv virtualenv-init -)"

# Local configs

if [ -f ~/.zshrc_local ]
then
	source ~/.zshrc_local
fi

