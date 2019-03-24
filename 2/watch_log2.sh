#!/bin/sh
#. date: 2019-03-23
watch_file="/shared/tmp/crmrotate.pcap001"
destination_dir_part="/shared/tmp/log"
declare -i number
while [ True ] ; do
  destination_dir="${destination_dir_part}/$(date +%Y%m%d)/$(date +%H)"
  if [ "${destination_dir}" != "${new_dir}" ] ; then
    new_dir=${destination_dir}
    if [ -d "${destination_dir}" ] ; then
      ls -t ${destination_dir}/crmrotate.pcap.* > /dev/null 2>&1
      test_=$?
      if [ "${test_}" == "0" ] ; then
        number_t=$(ls -t ${destination_dir}/crmrotate.pcap.* | head -1 | awk -F. '{print $3}')
        if [ ${number_t:0:2} == "00" ] ; then
          number=${number_t:2}+1
        elif [ ${number_t:0:1} == "0" ] ; then
          number=${number_t:1}+1
        else
          number=${number_t}+1
        fi
      else
        number=0
      fi
    else
      mkdir -p ${destination_dir}
      number=0
    fi
  fi
  time_stamp_001=$(ls -l --time-style=full-iso ${watch_file} | awk '{print $7}')
  if [ "${time_stamp_001}" != "${printed}" ] ; then
    printed=${time_stamp_001}
    if [ "${#number}" -eq 1 ] ; then
      rotate_number="00${number}"
    elif [ "${#number}" -eq 2 ] ; then
      rotate_number="0${number}"
    else
      rotate_number="${number}"
    fi
    destination_file="crmrotate.pcap.${rotate_number}"
    echo ${watch_file} ${destination_dir}/${destination_file}
    /bin/cp ${watch_file} ${destination_dir}/${destination_file}
    number=${number}+1
  fi
  sleep 1
done
