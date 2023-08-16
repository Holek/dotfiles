#!/usr/bin/env bash

echo "Installing Oh-My-ZSH"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Aliasing dotfiles"
local pwd="$(command pwd)"
(PWD="`pwd`" cd $HOME &&
  ln -s "${PWD}/.ackrc"  &&
ln -s "${PWD}/.aliasrc" &&
ln -s "${PWD}/.ctags" &&
ln -s "${PWD}/.gemrc" &&
ln -s "${PWD}/.vimrc" &&
ln -s "${PWD}/.zshrc" &&
ln -s "${PWD}/.tmux".conf &&
ln -s "${PWD}/gitconfig" .gitconfig &&
ln -s "${PWD}/gitattributes" .gitattributes &&
ln -s "${PWD}/.gitignore")
#ln -s "${PWD}/robbyrussell-mine.zsh-theme" "${HOME}/.oh-my-zsh/custom/robbyrussell-mine.zsh-theme"

echo "Accepting XCode license and installing it to install Homebrew"
sudo xcodebuild -license accept
sudo xcode-select --install
echo "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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

echo "git clone git@github.com:bric3/nice-exit-code.git ~/.oh-my-zsh/custom/plugins/nice-exit-code
git clone https://github.com/buonomo/yarn-extra-completion ~/.oh-my-zsh/custom/plugins/yarn-extra-completion
"

