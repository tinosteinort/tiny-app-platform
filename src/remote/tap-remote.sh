#!/bin/bash

set -e


REMOTE_APP_BASE="$1"
remoteTapCommand="remote-$2"
remoteTapCommandParams="${@:3}"

cd "$REMOTE_APP_BASE/appbase"
echo "tap app base: " `pwd`

function functionNameExist() {
    local functionName=$1
    local typeOfFunction=`type -t "$functionName"`
    if [ "$typeOfFunction" = "function" ]; then
        echo true
    else
        echo false
    fi
}

function remote-tap-apps() {
    echo *
}

functionExist=`functionNameExist "$remoteTapCommand"`
if [ "$functionExist" = true ]; then
    "$remoteTapCommand" "$remoteTapCommandParams"
else
    echo "Unknown remote command $remoteTapCommand"
    exit 1
fi
