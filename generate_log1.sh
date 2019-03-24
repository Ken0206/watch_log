#!/bin/sh

destination_dir="/shared/tmp"
[ -d "${destination_dir}" ] || mkdir -p ${destination_dir}

# 查哪個檔案流水編號最新，決定接續檔案流水編號
declare -i follow_number
ls -t ${destination_dir}/crmrotate.pcap* > /dev/null 2>&1
test_1=$?
if [ ${test_1} == "0" ] ; then

  last_file_name=$(ls -t ${destination_dir}/crmrotate.pcap* | head -1)
  number_t=${last_file_name:${#last_file_name}-3}
  if [ ${number_t:0:2} == "00" ] ; then
    follow_number=${number_t:2}+1
  elif [ ${number_t:0:1} == "0" ] ; then
    follow_number=${number_t:1}+1
  else
    follow_number=${number_t}+1
  fi
  [ ${follow_number} -eq 200 ] && follow_number=0
else
  # 沒有找到之前的 log 檔
  follow_number=0
fi

while [ True ] ; do

# 3 字元，不足補 0 成 3 字元
  if [ "${#follow_number}" -eq 1 ] ; then
    rotate_number="00${follow_number}"
  elif [ "${#follow_number}" -eq 2 ] ; then
    rotate_number="0${follow_number}"
  else
    rotate_number="${follow_number}"
  fi
  file_name="${destination_dir}/crmrotate.pcap${rotate_number}"
  echo "${RANDOM}" > ${file_name}
  echo ${file_name}

# 檔案流水編號 000~199
  if [ "${follow_number}" -eq 199 ] ; then
    follow_number=-1
  fi
  follow_number=${follow_number}+1

# 每 10 秒寫入有流水編號的新檔案
  sleep 10 
done
