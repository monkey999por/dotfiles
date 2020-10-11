#!/bin/bash

# ~/.bash_aliases に配置

# ll
alias l='ls -alF'

# cd系
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# windows dust box
# rm系のコマンドはこれに置き換えて使用する
alias rm="echo use custom command \"dust\"     usage\: dust \<directory or like file\>"

#windows cmd.exe的な
alias cls='clear'

#サクラエディタ　WSLならこういうこともできる
alias s='sakura.exe'
