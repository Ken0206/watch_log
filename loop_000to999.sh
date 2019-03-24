#!/bin/sh
# 產生三位數 000 ~ 999 循環
# date: 2019-03-23 

declare -i number=0
while [ True ] ; do
    if [ "${#number}" -eq 1 ] ; then
      rotate_number="00${number}"
    elif [ "${#number}" -eq 2 ] ; then
      rotate_number="0${number}"
    #elif [ "${#number}" -eq 3 ] ; then
    #  rotate_number="00${number}"
    #elif [ "${#number}" -eq 4 ] ; then
    #  rotate_number="0${number}"
    else
      rotate_number="${number}"
    fi
    echo ${rotate_number}
    if [ "${number}" == 999 ] ; then
      number=-1
    fi
    number=${number}+1
    #sleep 1
done
