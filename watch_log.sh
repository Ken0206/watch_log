#!/bin/sh
#. date: 2019-03-27
destination_dir_part="/shared/tmp/log"
[ -d ${destination_dir_part} ] || mkdir -p ${destination_dir_part}
log_file="${0%/*}/log_watch_log.txt"
declare -i number
while [ True ] ; do
  destination_dir="${destination_dir_part}/$(date +%Y%m%d)/$(date +%H)"
  if [ "${destination_dir}" != "${new_dir}" ] ; then
    new_dir=${destination_dir}
    if [ -d "${destination_dir}" ] ; then
      number_t=$(ls -t ${destination_dir}/crmrotate.pcap.* | head -1 | awk -F. '{print $3}')
      if [ ${number_t:0:2} == "00" ] ; then
        number=${number_t:2}+1
      elif [ ${number_t:0:1} == "0" ] ; then
        number=${number_t:1}+1
      else
        number=${number_t}+1
      fi
    else
      mkdir -p ${destination_dir}
      number=0
    fi
  fi
  file_name=$(ls -tr /shared/tmp/crmrotate.pcap* | tail -2 | head -1)
  if [ "${file_name}" != "${copied_file}" ] ; then
    copied_file=${file_name}
    if [ "${#number}" -eq 1 ] ; then
      rotate_number="00${number}"
    elif [ "${#number}" -eq 2 ] ; then
      rotate_number="0${number}"
    else
      rotate_number="${number}"
    fi
    destination_file="crmrotate.pcap.${rotate_number}"
    echo "$(date +%Y/%m/%d" "%H:%M:%S) cp ${file_name} ${destination_dir}/${destination_file}" | tee -a ${log_file}
    /bin/cp ${file_name} ${destination_dir}/${destination_file} &
    number=${number}+1
  fi
  sleep 1
done
