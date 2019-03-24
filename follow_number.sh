#!/bin/sh
# 接續檔案流水編號

destination_dir="/shared/tmp"
[ -d "${destination_dir}" ] || mkdir -p ${destination_dir}
declare -i follow_number

while [ True ] ; do
  # 查哪個檔案流水編號最新，決定接續檔案流水編號
  last_file_name=$(ls -t ${destination_dir} | head -1)
  number_t=${last_file_name:${#last_file_name}-3}
  if [ ${number_t:0:2} == "00" ] ; then
    follow_number=${number_t:2}+1
  elif [ ${number_t:0:1} == "0" ] ; then
    follow_number=${number_t:1}+1
  else
    follow_number=${number_t}+1
  fi
  [ ${follow_number} -eq 200 ] && follow_number=0
  if [ "${follow_number}" != "${displayed_number}" ] ; then
    displayed_number=${follow_number}
    echo ${follow_number}
  fi

  sleep 1
done
