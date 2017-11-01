#!/bin/bash

#######################################################
# Vim
#######################################################
# first clone Vundle
#git clone https://github.com/VundleVim/Vundle.vim.git $PWD/vim/.vim
# then setup symbolic links
# Setup symbolic link to .vimrc, if using neovim make symlink ~/.config/nvim/init.vim
if [ -L ~/.vimrc ]; then rm ~/.vimrc; fi
ln -s $PWD/vim/vim/init.vim ~/.vimrc
if [ -L ~/.vim ]; then rm ~/.vim; fi
ln -s $PWD/vim/vim ~/.vim
if [ -L ~/.config/nvim ]; then rm ~/.nvim; fi
ln -s $PWD/vim/vim ~/.config/nvim

# install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#######################################################
# Bash
#######################################################
if [ -L ~/.bash_aliases ]; then rm ~/.bash_aliases; fi
ln -s $PWD/bash/bash_aliases ~/.bash_aliases

#######################################################
# Git
#######################################################
if [ -L ~/.gitconfig ]; then rm ~/.gitconfig; fi
ln -s $PWD/git/gitconfig ~/.gitconfig
