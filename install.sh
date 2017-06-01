#!/bin/bash

echo "Installing vim awesome..."

echo "Copy .vimrc"
cp ./vim/vimrc ~/.vimrc

if [ ! -d ~/.vim/bundle/Vundle.vim/ ]
then
    echo "Copy .vim/"
    if [ ! -d ~/.vim/ ]
    then
        mkdir ~/.vim/
    fi
    if [ ! -d ~/.vim/bundle/ ]
    then
        mkdir ~/.vim/bundle/
    fi
    cp -R ./vim/bundle/ ~/.vim/bundle/
fi

echo "Copy colors"
if [ ! -d ~/.vim/colors/ ]
then
    mkdir ~/.vim/colors/
fi
cp -R ./vim/vim-colors-solarized/colors/ ~/.vim/colors/

echo "Install plugins"
vim +PluginInstall +qall
echo "Clean plugins"
vim +PluginClean +qall

echo "Install powerline fonts"
./other/fonts/install.sh

echo "Copy .tmux.conf"
if [ ! -f ~/.tmux.conf ]
then
    cp ./other/tmux.conf ~/.tmux.conf
else
    sed -i '/# ----- Begin vim-awesome -----/,/# ----- End vim-awesome -----/ d' ~/.tmux.conf
    cat ./other/tmux.conf >> ~/.tmux.conf
fi

echo "Copy .zshrc"
if [ ! -f ~/.zshrc ]
then
    cp ./other/zshrc ~/.zshrc
else
    sed -i '/# ----- Begin vim-awesome -----/,/# ----- End vim-awesome -----/ d' ~/.zshrc
    cat ./other/zshrc >> ~/.zshrc
fi

read -p "Install gnome terminal colors solarized (Y/n)? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    ./other/gnome-terminal-colors-solarized/install.sh
fi

echo "----- Successfully installed ------"
