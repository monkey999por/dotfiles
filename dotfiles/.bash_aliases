#!/bin/bash

# ls エイリアス
if ls --color=auto &>/dev/null; then
    # GNU ls (Linux)
    alias ls='ls --color=auto'
    alias l='ls -laF --time-style="+%Y-%m-%d %H:%M:%S"'
else
    # BSD ls (macOS)
    alias ls='ls -G'
    alias l='ls -laF'
fi

alias ll='ls -alF'
alias la='ls -A'

# cd エイリアス
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# その他
alias cls='clear'

# grep に色を付ける
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# 日本語 man ページ
if man --locale=ja_JP.UTF-8 ls &>/dev/null 2>&1; then
    alias mj="man --locale=ja_JP.UTF-8"
fi

# ファイル検索エイリアス
# ファイル名で検索
alias f='find . -type f -iname'

#ファイル内容で検索
alias g='grep -RIn'

# claude 
alias sclaude='claude --allow-dangerously-skip-permissions'
alias fclaude='claude --permission-mode acceptEdits'
