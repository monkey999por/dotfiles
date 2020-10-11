#!/bin/bash

SCRIPT_DIR="${HOME}/dotfiles"
DOTFILES="${SCRIPT_DIR}/dotfiles"
BACKUP="${SCRIPT_DIR}/bk_defualt/$(date "+%Y%m%d_%H%M%S")"

#1. set symbolic link
# TODO -> バックアップして書き込み権限をなくす(削除もできないようにできる？)
if [ ! -d ${BACKUP} ]; then
 mkdir -p ${BACKUP}
fi

# TODO -> リンク切れだったらどうする
# TODO -> ディレクトリでもちゃんと動くか確認
for i in $(ls -aAl --format=single-column ${DOTFILES}); do
 #back up
 #is exist file ? 
 if [ -f "${HOME}/$i" -o -d "${HOME}/$i" ]; then
  cp -f "${HOME}/$i" "${BACKUP}"
  rm "${HOME}/$i"

 #is exist link and not find path? 
 elif [ -L "${HOME}/$i" ]; then
  #元のファイルの場所を検索してバックアップする TODO
  echo $i with link
 fi

 ln -snfv "${DOTFILES}/$i" "${HOME}/$i"
done

#2. make Directory my workspace(like windows)
. "${SCRIPT_DIR}/custom/set_home.sh"

#3. my custom command
for c in "${SCRIPT_DIR}/custom/command/*.sh"; do
 echo $c
 . $c
done

