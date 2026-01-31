#!/bin/bash
# dotfiles復元スクリプト
# バックアップからファイルを復元し、シンボリックリンクを削除する

set -e

# スクリプトのあるディレクトリを基準にする
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_BASE="${SCRIPT_DIR}/bk_defualt"

# 色付き出力
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m'

info()    { echo -e "${GREEN}[INFO]${NC} $1"; }
warn()    { echo -e "${YELLOW}[WARN]${NC} $1"; }
error()   { echo -e "${RED}[ERROR]${NC} $1"; }

# 使用方法
usage() {
    echo "Usage: $0 [BACKUP_DIR]"
    echo ""
    echo "Arguments:"
    echo "  BACKUP_DIR  復元するバックアップディレクトリのパス"
    echo "              省略時は最新のバックアップを使用"
    echo ""
    echo "Examples:"
    echo "  $0                                    # 最新のバックアップから復元"
    echo "  $0 ~/dotfiles/bk_defualt/2024_01_15_12_30_45"
    echo ""
    echo "Available backups:"
    if [ -d "${BACKUP_BASE}" ]; then
        ls -1 "${BACKUP_BASE}" 2>/dev/null | while read dir; do
            echo "  ${BACKUP_BASE}/${dir}"
        done
    else
        echo "  (none)"
    fi
}

# バックアップディレクトリの決定
if [ -n "$1" ]; then
    if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        usage
        exit 0
    fi
    BACKUP="$1"
else
    # 最新のバックアップを使用
    if [ ! -d "${BACKUP_BASE}" ]; then
        error "No backup directory found: ${BACKUP_BASE}"
        exit 1
    fi
    BACKUP="${BACKUP_BASE}/$(ls -1 "${BACKUP_BASE}" | tail -n 1)"
fi

# バックアップディレクトリの存在確認
if [ ! -d "${BACKUP}" ]; then
    error "Backup directory not found: ${BACKUP}"
    echo ""
    usage
    exit 1
fi

# バックアップが空でないか確認
if [ -z "$(ls -A "${BACKUP}")" ]; then
    error "Backup directory is empty: ${BACKUP}"
    exit 1
fi

echo ""
info "Restoring from: ${BACKUP}"
echo ""

# 復元処理
restored=0
for i in "${BACKUP}"/.*; do
    filename=$(basename "$i")
    case "$filename" in .|..) continue ;; esac

    target="${HOME}/${filename}"

    # 現在のシンボリックリンク/ファイルを削除
    if [ -e "$target" ] || [ -L "$target" ]; then
        rm -rf "$target"
    fi

    # バックアップから復元
    cp -rf "$i" "$target"
    info "Restored: $filename"
    restored=$((restored + 1))
done

echo ""
echo "====================================="
info "Restore complete!"
echo "  Restored: $restored files"
echo "====================================="
echo ""
echo "Please restart your shell or run: source ~/.bashrc"
