#!/bin/bash

SCRIPT_DIR="${HOME}/dotfiles"
DOTFILES="${SCRIPT_DIR}/dotfiles"
BACKUP="${SCRIPT_DIR}/bk_defualt/$(date "+%Y_%m_%d_%H_%M_%S")"
CUSTOM="${SCRIPT_DIR}/custom"

. "${SCRIPT_DIR}/setting.sh"

#1. set symbolic link ~/.XXX -> dotfiles/dotfiles/.XXX
mkdir -p ${BACKUP}

for i in $(ls -Al --format=single-column ${DOTFILES}); do
    #back up to ${BACKUP}
    if [ -f "${HOME}/$i" -o -d "${HOME}/$i" ]; then
        cp -rf "${HOME}/$i" "${BACKUP}/"
        rm -r "${HOME}/$i"
    fi

    ln -snfv "${DOTFILES}/$i" "${HOME}/$i"
done

#2. make Directory my workspace(like windows)
. "${CUSTOM}/set_home.sh"

#3. my custom command
for c in $(ls -Al --format=single-column ${SCRIPT_DIR}/bin/); do
    . "${SCRIPT_DIR}/bin/$c"
done

# install extentions what is defined in the "install_targets"
if [ ${IS_INSTALL_EXTENTIONS} = "true" ]; then
    . "${CUSTOM}/extentions_list.sh"
else
    echo "skip install extentions command.."
fi