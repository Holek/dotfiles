export ZSH=/Users/holek/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(gitfast rails ruby docker osx encode64 gem ssh-agent tig tmux)

source $ZSH/oh-my-zsh.sh
export GOPATH=~/.go
export PATH="$PATH:$GOPATH/bin:$HOME/.rvm/bin" # Add RVM to PATH for scripting
source ~/dotfiles/.aliasrc
source ~/.secrets

ssh-add -K > /dev/null
