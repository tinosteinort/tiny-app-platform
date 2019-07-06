#!/bin/bash

set -e

appbase=$1

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

readPID() {
    local appPID

    if [[ -e $pidFile ]]
    then
        appPID=$(<"$pidFile")
    else
        appPID=''
    fi

    echo "$appPID"
}

deletePidFile() {
    if [[ -e $pidFile ]]
    then
        rm "$pidFile"
    fi
}

appIsRunning() {
    local pidToCheck=`readPID`
    local running

    if [[ -z "$pidToCheck" ]]  # if pidToCheck is empty (this is the case if there is no PID file)
    then
        running=false
    else
        if ps -p "$pidToCheck" > /dev/null  # Checks if there is a process with this PID
        then
            running=true
        else
            running=false
        fi
    fi

    echo "$running"
}

printRunningInfo() {
    local appname=$1
    local running=$2

    local status=''
    local formatting=''

    if [[ $running = true ]]
    then
        status="running"
        formatting="${GREEN}%-30s${NC}"
    else
        status="not running"
        formatting="${RED}%-30s${NC}"
    fi
    printf "%-30s - $formatting\n" "$projectName" "$status"
}


cd "$appbase"

for dir in */
do
    dir="${dir%*/}"
    projectName="${dir##*/}"

    project="$appbase/$projectName"
    pidFile="$project/PID"

    running=`appIsRunning`

    if [[ $running = false ]]
    then
        deletePidFile
    fi
    printRunningInfo "$projectName" "$running"

done
