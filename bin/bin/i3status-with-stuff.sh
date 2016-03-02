#!/bin/bash

# shell scipt to prepend i3status with more stuff

py3status --config ~/.i3status.conf | while :
do
    read line
    LG=$(/home/m/bin/xkblayout-state print "%s")
    if [ $LG == "us" ]
    then
        dat="[{ \"full_text\": \"LANG: $LG\", \"color\":\"#009E00\" },"
    else
        dat="[{ \"full_text\": \"LANG: $LG\", \"color\":\"#C60101\" },"
    fi
    echo "${line/[/$dat}" || exit 1
done
