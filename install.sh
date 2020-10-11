#!/bin/bash
cd ~/dotfiles

set DOTFILES="~/dotfiles/dotfiles/"

# set symbolic link
# バックアップして書き込み権限をなくす(削除もできないようにできる？)
if [ ! -d backup_defualt ]; then
 mkdir backup_defualt
fi


# TODO -> リンク切れだったらどうする
# TODO -> ディレクトリでもちゃんと動くか確認
cd ${DOTFILES}
for i in .??*; do
 ln -snfv ${DOTFILES}/$i ~/$i
 if [ -e ~/$i ]; then
  echo ~/$i
  ln -snfv $i ~/$i
 fi
 # ln -snfv dotfiles/$i ~/$
done
cd ..

return

cp ~/.bash_aliases dotfiles/backup_defualt/
cp ~/.inputrc dotfiles/backup_defualt/
cp ~/.gitconfig dotfiles/backup_defualt/

rm  ~/.bash_aliases
rm  ~/.inputrc
rm  ~/.gitconfig

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

#3. make Directory my workspace(like windows)
. script/mkdir_in_HOME.sh

# ext
#read custom command
for i in dotfiles/custom_command/*.sh; do
 . $i
done

