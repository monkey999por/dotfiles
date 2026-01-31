# CLAUDE.md

このファイルは、Claude Code (claude.ai/code) がこのリポジトリで作業する際のガイダンスを提供します。

## 言語設定

このリポジトリでのやりとりは全て日本語で行ってください。

## 概要

WSL (Ubuntu) / Linux 用の dotfiles リポジトリ。bash 専用。シェル設定と開発環境のセットアップを管理する。

## インストール

```bash
cd ~
git clone https://github.com/monkey999por/dotfiles.git
cd dotfiles
./install.sh
```

## リポジトリ構成

- **dotfiles/** - `$HOME` にシンボリックリンクされる設定ファイル（`.bashrc`, `.profile`, `.gitconfig`, `.vimrc` 等）
- **custom_commands/** - カスタムコマンド（PATHに追加される）

## 主な動作

`install.sh` スクリプトの処理:

1. 既存の dotfiles を `bk_defualt/<タイムスタンプ>/` にバックアップ
2. `$HOME` から `dotfiles/` 内のファイルへシンボリックリンクを作成
3. `custom_commands/` をPATHに追加

## Git エイリアス（.gitconfig より）

- `git l` - 装飾付きグラフログ
- `git s` - ステータス
- `git rmh` - mixed リセット（HEAD）
- `git rhh` - hard リセット（HEAD）
