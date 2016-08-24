#!/bin/bash

#######################################################
# setup vim
#######################################################
# first clone Vundle
#git clone https://github.com/VundleVim/Vundle.vim.git $PWD/vim/.vim
# then setup symbolic links
if [ -L ~/.vimrc ]; then rm ~/.vimrc; fi
ln -s $PWD/vim/vimrc ~/.vimrc
if [ -L ~/.vim ]; then rm ~/.vim; fi
ln -s $PWD/vim/vim ~/.vim
if [ -L ~/.bash_aliases ]; then rm ~/.bash_aliases; fi
ln -s $PWD/bash/bash_aliases ~/.bash_aliases
