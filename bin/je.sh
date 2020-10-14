#日本語から英語へ(japanese to englise)
#参考
# https://qiita.com/tanabee/items/c79c5c28ba0537112922
# https://qiita.com/satto_sann/items/be4177360a0bc3691fdf
# https://script.google.com/home?hl=ja
function je () {
 if [ -z "${@}" ]; then
  echo it has no argument
  return
 fi

 chrome.exe "https://translate.google.co.jp/?hl=ja#view=home&op=translate&sl=ja&tl=en&text=\"$(echo ${@}| sed "s/ /+/g")\""

 #local result=$(curl -L "https://script.google.com/macros/s/AKfycbyWDoCWmfmiGPA7JqGpH9_ec2f90tlIFRnKW2JHEWRfyQtXpahd/exec?text=\"$(echo ${@}| sed "s/ /+/g")\"&source=ja&target=en")
 #echo -e "\n"
 #echo "${@}"
 #echo -e "${result}\n"

}

