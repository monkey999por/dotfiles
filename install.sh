#!/bin/bash
cd ~

# 1. bask up defualt setting
if [ ! -d dotfiles/backup_defualt ]; then
 mkdir dotfiles/backup_defualt
fi

cp ~/.bash_aliases dotfiles/backup_defualt/
cp ~/.inputrc dotfiles/backup_defualt/
cp ~/.gitconfig dotfiles/backup_defualt/

#2. make symbolic link : TODO -> use for loop
if [ ! -L ~/.bash_aliases ]; then
 ln -s dotfiles/.bash_aliases ~/.bash_aliases
fi

if [ ! -L ~/.inputrc ]; then
 ln -s dotfiles/.inputrc ~/.inputrc
fi

if [ ! -L ~/.gitconfig ]; then
 ln -s dotfiles/.gitconfig ~/.gitconfig
fi

#3. make Directory my workspace
if [ ! -d ~/document.d ]; then
 mkdir ~/document.d
fi

if [ ! -d ~/develop.d ]; then
 mkdir ~/develop.d
fi

if [ ! -d ~/downloads.d ]; then
 mkdir ~/downloads.d
fi

if [ ! -d ~/back_up.d/defalut_dotfiles.d/ ]; then
 mkdir -p ~/back_up.d/defalut_dotfiles.d/
fi


