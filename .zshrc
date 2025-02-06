ZSH_THEME="robbyrussell-mine"

plugins=(gitfast rails ruby docker ubuntu encode64 gem ssh-agent tig tmux asdf python)

ssh-add -K 2> /dev/null

export ZSH=~/.oh-my-zsh
export GOPATH=~/.go
export PATH="$PATH:$GOPATH/bin:$HOME/.rvm/bin" # Add RVM to PATH for scripting

source $ZSH/oh-my-zsh.sh
source ~/dotfiles/.aliasrc
source ~/.secrets

eval "$(direnv hook zsh)"
