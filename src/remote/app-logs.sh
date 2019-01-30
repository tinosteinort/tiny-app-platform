#!/bin/bash

set -e

appbase=$1
appname=$2
logparam=$3


cd $appbase

if [ -e $appname ]
then
    project="$appbase/$appname"
    logFile="$project/logs.txt"

    if [ -e $logFile ]
    then
        if [ "$logparam" = "tail" ]
        then
            tail -f "$logFile"
        else
            cat "$logFile"
        fi
    fi
else
    echo "'$appname' does not exist"
    exit 1
fi
