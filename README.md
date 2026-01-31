# dotfiles

Ubuntu用のdotfiles（bash）

## Usage

```shell
cd ~
git clone https://github.com/monkey999por/dotfiles.git
cd dotfiles
./install.sh
```

## Restore

```shell
./restore.sh                           # 最新のバックアップから復元
./restore.sh bk_defualt/2024_01_15...  # 特定のバックアップから復元
```

## Structure

```
dotfiles/
├── install.sh          # インストールスクリプト
├── restore.sh          # 復元スクリプト
├── custom_commands/    # カスタムコマンド（PATHに追加される）
└── dotfiles/           # ドットファイル
    ├── .bashrc
    ├── .bash_aliases
    ├── .profile
    ├── .shrc_common
    ├── .git-prompt.sh
    ├── .gitconfig
    ├── .nanorc
    └── .vimrc
```

## References

[mathiasbynens's](https://github.com/mathiasbynens) dotfiles repository
