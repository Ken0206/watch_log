#!/bin/sh
# 顯示最新檔案,可能一直在寫入中，
# 如果要看完成的可能要找第2新的檔案，
# ls -t ${query_str} | head -2 | tail -1

query_str="/shared/tmp/crmrotate.pcap*"
while [ True ] ; do
  newset_file=$(ls -t ${query_str} | head -1)
  if [ "${newset_file}" != "${displayed_file}" ] ; then
    displayed_file=${newset_file}
    echo ${newset_file}
  fi
  sleep 1
done
