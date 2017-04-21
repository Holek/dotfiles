#/usr/bin/env sh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

ln -s .ackrc ~/.ackrc
ln -s .aliasrc ~/.aliasrc
ln -s .ctags ~/.ctags
ln -s .gemrc ~/.gemrc
ln -s .vimrc ~/.vimrc
ln -s .zshrc ~/.zshrc
ln -s .tmux.conf ~/.tmux.conf
ln -s gitconfig ~/.gitconfig
ln -s gitattributes ~/.gitattributes
ln -s .gitignore ~/.gitignore

sudo xcodebuild -license accept
sudo xcode-select --install
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap Homebrew/bundle
brew bundle

tmux source-file ~/.tmux.conf

vim +PluginInstall +qall
(cd ~/.vim/bundle/YouCompleteMe && ./install.py --gocode-completer)
