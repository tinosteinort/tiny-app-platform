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

    echo "$appPID"
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

deleteProjectBin() {
    if [[ -e "$projectBin" ]]
    then
        rm -r "$projectBin"
    fi
}


cd "$appbase"

# Init empty application
if [[ ! -e "$appname" ]]
then
    mkdir "$appname"
fi

project="$appbase/$appname"
projectBin="$project/bin"
pidFile="$project/PID"
envcfg="$project/environment.cfg"

# Do not update if the application is running -> exit with 1
if [[ -e $pidFile ]]
then
    running=`appIsRunning`

    if [[ $running = true ]]
    then
        echo "Could no update application, because application is running"
        exit 1
    fi
fi

# Init environment.cfg
if [[ ! -e $envcfg ]]
then
    touch "$envcfg"
    echo "# Define variables in the following way (don't miss the 'export'):" >> "$envcfg"
    echo "#   export VAR_NAME=\"VALUE\"" >> "$envcfg" >> "$envcfg"
fi

# Delete old files
deleteProjectBin
