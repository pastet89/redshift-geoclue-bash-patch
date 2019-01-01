#!/bin/bash

running_check() {
    if [[ $1 == *"redshift -l"* ]]; then
        eval $(echo msg_title="Success")
        if [[ $2 == "1" ]]; then
            notify-send "$msg_title" "Redshift started with proper local coordinates!"
        else
            notify-send "$msg_title" "Redshift started with 0:0 coordinates!"
        fi
    else
        eval $(echo msg_title="Fail")
        notify-send "$msg_title" "Redshift can't be started!"
    fi
}
: '
Provided that the script can be run immediately after
the computer startup, wait few seconds till we are sure
the internet connection is established.
'
sleep 5
redshift -l $(curl ipinfo.io | jq .loc | tr ',' ':' | tr '"' ' ') &
: 'Sleep 3 more seconds after trying to run it before checking if it is
running to make sure it has not crashed just after the initial startup'
sleep 3
running_check "$(ps ax | grep redshift)" "1"
if [[ $msg_title == "Fail" ]]; then
    sleep 1
    notify-send "Can't get coordinates" "Retrying with default coordinates"
    : '
    If the first startup, getting the coordinates from the internet has failed, 
    give it a try second time with default coordinates 0:0
    '
    redshift -l 0:0 &
    sleep 3
    running_check "$(ps ax | grep redshift)" "2"
fi
