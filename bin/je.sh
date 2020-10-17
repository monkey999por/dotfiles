#日本語から英語へ(japanese to englise)
#参考
# https://qiita.com/tanabee/items/c79c5c28ba0537112922
# https://qiita.com/satto_sann/items/be4177360a0bc3691fdf
# https://script.google.com/home?hl=ja
function je () {
    if [ -p /dev/stdin ]; then
        if [ -z "${@}" ]; then 
            local __str=`cat -`
        fi
    else
        local __str=$@
    fi

    if [ -z "${__str}" ]; then
        echo it has no argument
        return
    fi

    chrome.exe "https://translate.google.co.jp/?hl=ja#view=home&op=translate&sl=ja&tl=en&text=\"$(echo ${__str}| sed "s/ /+/g")\""
}

