#!/bin/bash

set -e

appbase=$1
appname=$2

readPID() {
    local appPID

    if [[ -e $pidFile ]]
    then
        appPID=$(<"$pidFile")
    else
        appPID=''
    fi

    # write the value of 'appPID' into to first passed argument -> return value
    eval "$1='$appPID'"
}

appIsRunning() {
    local pidToCheck
    readPID pidToCheck     # 'readPID' fills the result into 'pidToCheck'

    if [[ -z $pidToCheck ]]  # if pidToCheck is empty (this is the case if there is no PID file)
    then
        eval "$1=false"
    else
        if ps -p "$pidToCheck" > /dev/null  # Checks if there is a process with this PID
        then
            eval "$1=true"
        else
            eval "$1=false"
        fi
    fi
}

stopApplication() {
    local pid
    pid=$1

    local psGroupOutput
    psGroupOutput=$(ps -o pgid -p "$pid")
    echo 'Determined PGID from:'
    echo "$psGroupOutput"

    local processGroupId
    processGroupId=$(echo "$psGroupOutput" | awk '/[0-9]+/ { print $1; }')
    echo "Determined PGID: $processGroupId"

    echo 'kill processes'
    pkill -g "$processGroupId"
}

cd "$appbase"

if [[ -e $appname ]]
then
    project="$appbase/$appname"
    pidFile="$project/PID"


    running=false
    appIsRunning running

    if [[ $running = true ]]
    then
        appPid=''
        readPID appPid

        if [[ -z $pidToCheck ]]
        then
            stopApplication "$appPid"
        fi
    else
        echo "Application '$appname' is not running"
        exit 1
    fi
else
    echo "Application '$appname' does not exist"
    exit 1
fi
