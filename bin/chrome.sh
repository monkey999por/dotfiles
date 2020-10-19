#! /bin/bash

# Open Chrome.exe with File (convert path separetor for windows)
#動かんが
function chrome_ () {

    if [ -z "${@}" ]; then 
        chrome.exe
    else
	#円マークはエスケープが必要だが、円マーク二つのエスケープのやり方がわからんので保留
        local file=$(echo $(wslpath -a -w ${@}) | sed -e "s/\//\\\\/g" )
        echo $file  
        return
        chrome.exe '"$file"'
    fi
}

alias chrome="chrome.exe"
