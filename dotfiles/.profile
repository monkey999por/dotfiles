# ~/.profile: ログインシェル用設定ファイル

# bashの場合は.bashrcを読み込む
if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# ============================================
# PATH設定
# ============================================
# ユーザーのプライベートbin
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

# .local/bin（pipなどでインストールされるコマンド）
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

# ============================================
# 環境固有設定
# ============================================
# deno
[ -f "$HOME/.deno/env" ] && . "$HOME/.deno/env"

# cargo
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# Android SDK
if [ -d "$HOME/Android/Sdk" ]; then
    export ANDROID_HOME="$HOME/Android/Sdk"
    export PATH="$PATH:$ANDROID_HOME/emulator"
    export PATH="$PATH:$ANDROID_HOME/platform-tools"
fi

# goenv
if [ -d "$HOME/.goenv" ]; then
    export GOENV_ROOT="$HOME/.goenv"
    export PATH="$GOENV_ROOT/bin:$PATH"
    eval "$(goenv init -)"
    export PATH="$GOROOT/bin:$PATH"
    export PATH="$PATH:$GOPATH/bin"
fi
