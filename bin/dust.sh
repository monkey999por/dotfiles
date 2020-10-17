 #!/bin/bash

# like a windows dust box
# if delete file or directory, move dust box directory
function dust () {
    if [ -z ${DUSTBOX} ]; then
        echo not defined '$DUSTBOX'
        return
    fi

    if [ -h "${1}" ]; then
        cp --attributes-only "${1}" "${DUSTBOX}"
        rm -f "${1}"
    elif [ -f "${1}" ]; then
        cp "${1}" "${DUSTBOX}"
        rm -f "${1}"
    elif [ -d "${1}" ]; then
        cp -r "${1}" "${DUSTBOX}"
        rm -r "${1}"
    else 
        echo -e "can't delete this. it is not file or directory or symbolic link.\nuse \"rm\" command."
    fi

}
