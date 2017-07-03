#/usr/bin/env sh

echo "Installing Oh-My-ZSH"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Aliasing dotfiles"
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

echo "Accepting XCode license and installing it to install Homebrew"
sudo xcodebuild -license accept
sudo xcode-select --install
echo "Installing Homebrew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo "Installing brew formulas from Brewfile"
brew tap Homebrew/bundle
brew bundle

echo "sourcing tmux config"
tmux source-file ~/.tmux.conf

echo "Installing vim plugins"
vim +PluginInstall +qall
(cd ~/.vim/bundle/YouCompleteMe && ./install.py --gocode-completer)
