#!/bin/bash

set -e

remoteTapCommandName=$1
remoteTapCommand="remote-$remoteTapCommandName"
remoteTapCommandParams=${@:2}

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
    echo 'tap apps on remote'
    hostname
    pwd
    tree
}

functionExist=`functionNameExist "$remoteTapCommand"`
if [ "$functionExist" = true ]; then
    "$remoteTapCommand" "$remoteTapCommandParams"
else
    echo "Unknown remote command $remoteTapCommand"
    exit 1
fi
