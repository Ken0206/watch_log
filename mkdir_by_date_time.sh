#!/bin/sh
# 以 現在日期/現在時間 建子目錄
# date 2019-03-23

destination_dir_part="/shared/tmp/log"
while [ True ] ; do
  destination_dir="${destination_dir_part}/$(date +%Y%m%d)/$(date +%H%M)"

  # 檢查本 script 是否已 mkdir
  if [ "${destination_dir}" != "${new_dir}" ] ; then
    new_dir=${destination_dir}
    echo ${destination_dir}
    mkdir -p ${destination_dir}

    # 檢查 目錄是否已存在
    [ -d "${destination_dir}" ] || mkdir -p ${destination_dir}
  fi

  sleep 1
done
