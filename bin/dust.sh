 #!/bin/bash

# like a windows dust box
# if delete file or directory, move dust box directory
function dust () {

    local here=$(pwd)
    if [ -z ${DUSTBOX} ]; then
        echo not defined '$DUSTBOX'
        return
    elif [ -z ${1} ]; then
        return
    fi
    
    #バックアップするパスを取得
    #echo $(dirname $(pwd)${1} |sed "s/^\///g")
    local backup_path=$(dirname ${1})
    for p in ${backup_path//\/ }; do
        cd $p
    done

    #バックアップ先ディレクトリ
    backup_path=${DUSTBOX}/$(pwd | sed "s/^\///g" )
    echo "back up: ${backup_path}"
    mkdir -p ${backup_path}

    #削除対象
    local remove_target="$(pwd)/$(basename ${1})"
    echo "remove target: ${remove_target}"
    
    if [ -h "${1}" ]; then
        cp --attributes-only "${1}" "${DUSTBOX}/"
        rm -f "${1}"
    elif [ -f "${remove_target}" ]; then
        cp -f "${remove_target}" "${backup_path}/"
        rm -f "${remove_target}"
    elif [ -d "${remove_target}" ]; then
        cp -rf "${remove_target}" "${backup_path}/"
        rm -r "${remove_target}"
    else 
        echo -e "can't delete this. it is not file or directory or symbolic link.\nuse \"rm\" command."
    fi
    echo -e "\n"
    tree ${backup_path}

}
