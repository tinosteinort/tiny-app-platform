#!/bin/bash

set -e

appbase=$1
appname=$2


cd "$appbase"

if [[ -e ${appname} ]]
then
    project="$appbase/$appname"
    logFile="$project/logs.txt"

    if [[ -e ${logFile} ]]
    then
        tail -f "$logFile"
    fi
else
    echo "'$appname' does not exist"
    exit 1
fi
