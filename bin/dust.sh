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

    #バックアップ先
    echo $(${DUSTBOX}/$(pwd | sed "s/^\///g" ))

    #削除対象
    echo $(pwd)/$(basename ${1})
    return 
    
    


    local destination=${DUSTBOX}/$(dirname ${1} |sed "s/^\///g")
    mkdir -p ${destination}
    
    if [ -h "${1}" ]; then
        cp --attributes-only "${1}" "${DUSTBOX}/"
        rm -f "${1}"
    elif [ -f "${1}" ]; then
        cp "${1}" "${destination}/"
        rm -f "${1}"
    elif [ -d "${1}" ]; then
        cp -r "${1}" "${destination}/"
        rm -r "${1}"
    else 
        echo -e "can't delete this. it is not file or directory or symbolic link.\nuse \"rm\" command."
    fi

    tree ${destination}

}
