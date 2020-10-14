#英語を翻訳する
#参考
# https://qiita.com/tanabee/items/c79c5c28ba0537112922
# https://qiita.com/satto_sann/items/be4177360a0bc3691fdf
# https://script.google.com/home?hl=ja
function je () {
 if [ -z "${@}" ]; then
  echo this is no argument
  return
 fi

 local result=$(curl -L "https://script.google.com/macros/s/AKfycbyWDoCWmfmiGPA7JqGpH9_ec2f90tlIFRnKW2JHEWRfyQtXpahd/exec?text=\"$(echo ${@}| sed "s/ /+/g")\"&source=en&target=ja")
 echo -e "\n"
 echo "${@}"
 echo -e "${result}\n"
}

