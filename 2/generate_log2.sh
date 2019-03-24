#!/bin/sh

destination_dir="/shared/tmp"
file_part="${destination_dir}/crmrotate.pcap"
[ -d "${destination_dir}" ] || mkdir -p ${destination_dir}

while [ True ] ; do
  rm -f "${file_part}199"

  for (( x=198 ; x>=0; x=x-1 )) ; do

# 3 字元，不足補 0 成 3 字元
    if [ "${#x}" -eq 1 ] ; then
      from_number="00${x}"
    elif [ "${#x}" -eq 2 ] ; then
      from_number="0${x}"
    else
      from_number="${x}"
    fi

    y=$((${x}+1))

# 3 字元，不足補 0 成 3 字元
    if [ "${#y}" -eq 1 ] ; then
      to_number="00${y}"
    elif [ "${#y}" -eq 2 ] ; then
      to_number="0${y}"
    else
      to_number="${y}"
    fi

    mv -f "${file_part}${from_number}" "${file_part}${to_number}" 2>/dev/null
    #echo "${file_part}${from_number} ${file_part}${to_number}"
    
  done

  echo "${RANDOM}" > "${file_part}000"
  echo "${RANDOM}"
  sleep 10
done
