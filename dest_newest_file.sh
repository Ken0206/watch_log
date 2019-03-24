#!/bin/sh
# 顯示最新檔案

watch_dir="/shared/tmp/log"
while [ True ] ; do
  newest_file=$(ls -trR ${watch_dir} | tail -1)
  if [ "${newest_file}" != "${displayed_file}" ] ; then
    displayed_file=${newest_file}
    echo "${newest_file}"
  fi
  sleep 1
done
