# ~/.bashrc: bash用設定ファイル

# 非対話モードでは何もしない
case $- in
    *i*) ;;
      *) return;;
esac

# ============================================
# bash固有オプション
# ============================================
shopt -s histappend         # 履歴ファイルに追記
shopt -s checkwinsize       # ウィンドウサイズを確認

# ============================================
# 履歴設定
# ============================================
HISTFILE=~/.bash_history
HISTCONTROL=ignoreboth      # 重複とスペース始まりを無視

# ============================================
# 共通設定読み込み
# ============================================
if [ -f ~/.shrc_common ]; then
    . ~/.shrc_common
fi

# ============================================
# lesspipe
# ============================================
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# ============================================
# Git設定
# ============================================
# git-prompt.sh の読み込み
if [ -f ~/.git-prompt.sh ]; then
    . ~/.git-prompt.sh
fi

# ============================================
# 補完設定
# ============================================
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# ============================================
# プロンプト設定
# ============================================
# debian chroot対応
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# カスタムプロンプト
if type __git_ps1 &>/dev/null; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[01;35m\]@\[\033[01;36m\]\h\[\033[00m\]: \[\033[01;34m\]\w\[\033[1;31m\]$(__git_ps1 " (%s)")\[\033[00m\]\n\[\e]0;\u@\h: \w\a\]$(echo -e "\U1F49B\U1F499\U1F49A\U1F49C") '
else
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[01;35m\]@\[\033[01;36m\]\h\[\033[00m\]: \[\033[01;34m\]\w\[\033[00m\]\n\[\e]0;\u@\h: \w\a\]$(echo -e "\U1F49B\U1F499\U1F49A\U1F49C") '
fi

# ============================================
# エイリアス設定
# ============================================
if [ -f "${HOME}/.bash_aliases" ]; then
    . "${HOME}/.bash_aliases"
fi

# ============================================
# カスタムコマンド
# ============================================
# install.sh が生成したパス設定を読み込む
if [ -f "${HOME}/.bash_custom_commands" ]; then
    . "${HOME}/.bash_custom_commands"
fi

# ============================================
# 環境固有設定（自動追加分）
# ============================================
# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# deno
[ -f "$HOME/.deno/env" ] && . "$HOME/.deno/env"

# cargo
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
