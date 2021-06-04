#!/bin/bash
#--------------------------------------------------------------------
# 
# Install dotfiles
#
#--------------------------------------------------------------------

source $(dirname $0)/arg_parse.sh

declare -A input_variables=(
   ["install"]="all"
)

declare -A input_functions=( 
   ["install"]="set_one_arg"
)

arg_parse_print=true
arg_parse_error=true

parse_arguments $@

exit_status=$?

if [ "$exit_status" != "0" ]; then
   echo "Error"
   exit $exit_status
fi

#--------------------------------------------------------------------
# General
#--------------------------------------------------------------------
# Make sure we have config directory
if [ ! -d ~/.config ]; then
   mkdir ~/.config   
fi

#--------------------------------------------------------------------
# Vim
#--------------------------------------------------------------------
if [ "${input_variables['install']}" == "all" ] || [ "${input_variables['install']}" == "vim" ]; then
   # first clone Vundle
   #git clone https://github.com/VundleVim/Vundle.vim.git $PWD/vim/.vim
   # then setup symbolic links
   # Setup symbolic link to .vimrc, if using neovim make symlink ~/.config/nvim/init.vim
   if [ -L ~/.vimrc ]; then rm ~/.vimrc; fi
   ln -s $PWD/vim/vim/init.vim ~/.vimrc
   if [ -L ~/.vim ]; then rm ~/.vim; fi
   ln -s $PWD/vim/vim ~/.vim
   if [ -L ~/.config/nvim ]; then rm ~/.config/nvim; fi
   ln -s $PWD/vim/vim ~/.config/nvim
   
   # install Vundle
   git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

#--------------------------------------------------------------------
# Bash
#--------------------------------------------------------------------
if [ "${input_variables['install']}" == "all" ] || [ "${input_variables['install']}" == "bash" ]; then
   if [ -L ~/.bash_aliases ]; then rm ~/.bash_aliases; fi
   ln -s $PWD/bash/bash_aliases ~/.bash_aliases
fi

#--------------------------------------------------------------------
# Git
#--------------------------------------------------------------------
if [ "${input_variables['install']}" == "all" ] || [ "${input_variables['install']}" == "git" ]; then
   if [ -L ~/.gitconfig ]; then rm ~/.gitconfig; fi
   ln -s $PWD/git/gitconfig ~/.gitconfig
fi

#--------------------------------------------------------------------
# Top
#--------------------------------------------------------------------
if [ "${input_variables['install']}" == "all" ] || [ "${input_variables['install']}" == "top" ]; then
   if [ -L ~/.toprc ]; then rm ~/.toprc; fi
   ln -s $PWD/top/toprc ~/.toprc
fi

#--------------------------------------------------------------------
# i3wm - i3 windows manager
#--------------------------------------------------------------------
if [ "${input_variables['install']}" == "all" ] || [ "${input_variables['install']}" == "i3" ]; then
   if [ -L ~/.config/i3 ]; then rm ~/.config/i3; fi
   ln -s $PWD/i3 ~/.config/i3
fi
