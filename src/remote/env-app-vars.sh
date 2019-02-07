#!/bin/bash

set -e

appbase=$1
appname=$2

cd "$appbase"

if [[ -e ${appname} ]]
then
    project="$appbase/$appname"
    envcfg="$project/environment.cfg"

    if [[ -e ${envcfg} ]]
    then
        envContent=$(<"$envcfg")
        echo "$envContent"
    fi
else
    echo "Application '$appname' does not exist"
    exit 1
fi
