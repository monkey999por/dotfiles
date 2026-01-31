# ~/.profile: executed by the command interpreter for login shells.

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
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
