#!/usr/bin/env bash

echo "Installing Oh-My-ZSH"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Aliasing dotfiles"
local pwd="$(command pwd)"
ln -s "${pwd}/.ackrc" ~/.ackrc
ln -s "${pwd}/.aliasrc" ~/.aliasrc
ln -s "${pwd}/.ctags" ~/.ctags
ln -s "${pwd}/.gemrc" ~/.gemrc
ln -s "${pwd}/.vimrc" ~/.vimrc
ln -s "${pwd}/.zshrc" ~/.zshrc
ln -s "${pwd}/.tmux".conf ~/.tmux.conf
ln -s "${pwd}/gitconfig" ~/.gitconfig
ln -s "${pwd}/gitattributes" ~/.gitattributes
ln -s "${pwd}/.gitignore" ~/.gitignore
ln -s "${pwd}/robbyrussell-mine.zsh-theme" "${HOME}/.oh-my-zsh/custom/robbyrussell-mine.zsh-theme"

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
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
(cd ~/.vim/bundle/YouCompleteMe && ./install.py --gocode-completer)

ln -s "${pwd}/bin/statsd" /usr/local/bin/statsd
touch ~/.hushlogin

echo "git clone git@github.com:bric3/nice-exit-code.git \$ZSH_CUSTOM/plugins/nice-exit-code"

