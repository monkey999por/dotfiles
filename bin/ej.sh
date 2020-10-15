#英語から日本語へ(english to japanese)
#参考
# https://qiita.com/tanabee/items/c79c5c28ba0537112922
# https://qiita.com/satto_sann/items/be4177360a0bc3691fdf
# https://script.google.com/home?hl=ja
function ej () {
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

    local result=$(curl -L "https://script.google.com/macros/s/AKfycbyWDoCWmfmiGPA7JqGpH9_ec2f90tlIFRnKW2JHEWRfyQtXpahd/exec?text=\"$(echo ${__str}| sed "s/ /+/g")\"&source=en&target=ja")
    echo -e "\n"
    echo "${__str}"
    echo -e "${result}\n"
}

