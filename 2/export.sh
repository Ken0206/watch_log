#!/bin/sh

grep -vE "^# |^$" watch_log2.sh.ken > watch_log2.sh
chmod u+x watch_log2.sh
