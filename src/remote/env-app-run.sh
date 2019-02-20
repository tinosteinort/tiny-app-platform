#!/bin/bash

set -e

appbase=$1
appname=$2

cd "$appbase"

if [[ -e $appname ]]
then
    project="$appbase/$appname"
    projectBin="$project/bin"
    runScript="$projectBin/run.sh"

    if [[ -x $runScript ]]
    then
        runScriptContent=$(<"$runScript")
        echo "$runScriptContent"
    else
        echo "Missing run file or file is not executable: '$runScript'"
        exit 1
    fi
else
    echo "Application '$appname' does not exist"
    exit 1
fi
