#!/bin/sh

grep -vE "# |^$" watch_log.sh.ken > watch_log.sh
chmod u+x watch_log.sh
