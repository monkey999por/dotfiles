# comment
# these extentions are installed when $IS.
declare -a install_targets=(
    "tree"
    "unzip"

    # japanese man page. use 'manj' command. ※manj defined in alias
    "language-pack-ja"
    "manpages-ja"
    "apache2"
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
    sudo apt install ${i}
done


# dotnet
# ref: https://docs.microsoft.com/ja-jp/dotnet/core/install/linux-ubuntu#1804-
wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb

sudo apt-get update
sudo apt-get install -y apt-transport-https && sudo apt-get update && sudo apt-get install -y dotnet-sdk-3.1

#curl https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh | sh
