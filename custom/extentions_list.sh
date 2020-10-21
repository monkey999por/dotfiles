# comment
# these extentions are installed when $IS.
declare -a install_targets=(
    "tree"
    "unzip"

    # japanese man page. use 'manj' command. ※manj defined in alias
    "language-pack-ja"
    "manpages-ja"

    "manpages-ja-dev"
    "make"
    "gcc"
    #game
    "cmatrix"

)

# install extentions what is defined in the "install_targets"
sudo apt update
sudo apt upgrade

for i in ${install_targets[@]} ; do
    sudo apt -y install ${i}
done

#curl https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh | sh