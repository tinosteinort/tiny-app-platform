#!/bin/bash

set -e

appbase=$1
appname=$2

savePID() {
    local pidToSave
    pidToSave=$1

    echo "$pidToSave" > "$pidFile"
}

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

deletePidFile() {
    if [[ -e $pidFile ]]
    then
        rm "$pidFile"
    fi
}

startApplication() {
    deletePidFile

    if [[ -e $envFile ]]
    then
        . "$envFile"
    fi

    nohup "$runScript" &>$logFile &
    local appPID
    appPID=$!

    savePID "$appPID"
}

appIsRunning() {
    local pidToCheck
    readPID pidToCheck     # 'readPID' fills the result into 'pidToCheck'

    if [[ -z $pidToCheck ]]  # if pidToCheck is empty (this is the case if there is no PID file)
    then
        eval "$1=false"
    else
        if ps -p $pidToCheck > /dev/null  # Checks if there is a process with this PID
        then
            eval "$1=true"
        else
            eval "$1=false"
        fi
    fi
}

startApplicationWithCheck() {
    local running
    appIsRunning running

    if [[ $running = true ]]
    then
        echo 'Application is already running'
        exit 1
    else
        startApplication
    fi
}


cd "$appbase"

if [[ -e $appname ]]
then
    project="$appbase/$appname"
    projectBin="$project/bin"
    runScript="$projectBin/run.sh"
    pidFile="$project/PID"
    envFile="$project/environment.cfg"
    logFile="$project/logs.txt"

    if [[ -x $runScript ]]
    then
        cd "$projectBin"
        startApplicationWithCheck
    else
        echo "Missing run file or file is not executable: '$runScript'"
        exit 1
    fi
else
    echo "'$appname' does not exist"
    exit 1
fi
