#!/bin/bash
# dotfilesインストールスクリプト（bash専用）
# 冪等性: 何度実行しても同じ結果になる
# リカバリ: 失敗時はバックアップから復元可能

set -e  # エラー時に停止

# スクリプトのあるディレクトリを基準にする
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES="${SCRIPT_DIR}/dotfiles"
CUSTOM_COMMANDS="${SCRIPT_DIR}/custom_commands"
BACKUP_BASE="${SCRIPT_DIR}/bk_defualt"
BACKUP="${BACKUP_BASE}/$(date '+%Y_%m_%d_%H_%M_%S')"

# 色付き出力
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

info()    { echo -e "${GREEN}[INFO]${NC} $1"; }
warn()    { echo -e "${YELLOW}[SKIP]${NC} $1"; }
error()   { echo -e "${RED}[ERROR]${NC} $1"; }

# バックアップが必要かチェック
need_backup=false
for i in "${DOTFILES}"/.*; do
    filename=$(basename "$i")
    case "$filename" in .|..) continue ;; esac

    target="${HOME}/${filename}"

    # すでに正しいシンボリックリンクならスキップ
    if [ -L "$target" ] && [ "$(readlink "$target")" = "${DOTFILES}/${filename}" ]; then
        continue
    fi

    # 実ファイル/ディレクトリが存在する場合はバックアップが必要
    if [ -e "$target" ] || [ -L "$target" ]; then
        need_backup=true
        break
    fi
done

# バックアップディレクトリ作成（必要な場合のみ）
if [ "$need_backup" = true ]; then
    mkdir -p "${BACKUP}"
    info "Backup directory: ${BACKUP}"
fi

# メイン処理
installed=0
skipped=0
backed_up=0

for i in "${DOTFILES}"/.*; do
    filename=$(basename "$i")
    case "$filename" in .|..) continue ;; esac

    target="${HOME}/${filename}"
    source="${DOTFILES}/${filename}"

    # すでに正しいシンボリックリンクが存在する場合はスキップ（冪等性）
    if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
        warn "$filename (already linked)"
        skipped=$((skipped + 1))
        continue
    fi

    # 既存ファイル/シンボリックリンクをバックアップ
    if [ -e "$target" ] || [ -L "$target" ]; then
        cp -rf "$target" "${BACKUP}/"
        rm -rf "$target"
        backed_up=$((backed_up + 1))
        info "Backed up: $filename"
    fi

    # シンボリックリンク作成
    ln -snfv "$source" "$target"
    installed=$((installed + 1))
done

# 空のバックアップディレクトリを削除
if [ -d "${BACKUP}" ] && [ -z "$(ls -A "${BACKUP}")" ]; then
    rmdir "${BACKUP}"
fi

# カスタムコマンドディレクトリの作成
if [ ! -d "${CUSTOM_COMMANDS}" ]; then
    mkdir -p "${CUSTOM_COMMANDS}"
    info "Created custom_commands directory"
fi

# カスタムコマンドのパス設定ファイルを生成
CUSTOM_COMMANDS_ENV="${HOME}/.bash_custom_commands"
echo "export PATH=\"${CUSTOM_COMMANDS}:\$PATH\"" > "${CUSTOM_COMMANDS_ENV}"
info "Created ${CUSTOM_COMMANDS_ENV}"

# カスタムコマンドに実行権限を付与
custom_chmod_count=0
for script in "${CUSTOM_COMMANDS}"/*; do
    [ -f "$script" ] || continue
    # 隠しファイル（.gitkeep等）はスキップ
    case "$(basename "$script")" in .*) continue ;; esac
    if [ ! -x "$script" ]; then
        chmod +x "$script"
        info "Made executable: $(basename "$script")"
        custom_chmod_count=$((custom_chmod_count + 1))
    fi
done

echo ""
echo "====================================="
info "Installation complete!"
echo "  Installed: $installed"
echo "  Skipped:   $skipped"
echo "  Backed up: $backed_up"
echo "  Custom commands: $custom_chmod_count made executable"
if [ "$backed_up" -gt 0 ]; then
    echo ""
    echo "Backup location: ${BACKUP}"
    echo "To restore: ./restore.sh ${BACKUP}"
fi
echo "====================================="
echo ""
echo "Custom commands: ${CUSTOM_COMMANDS}"
echo "  Place executable scripts here to use them as commands."
echo "  Example: chmod +x ${CUSTOM_COMMANDS}/my_script.sh"
echo ""
echo "Please restart your shell or run: source ~/.bashrc"
