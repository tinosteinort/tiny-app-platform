#!/bin/bash

set -e


SCRIPT_DIR="$(cd `dirname $0` && pwd)"
CONFIG_FILE="$SCRIPT_DIR/conf/tap.cfg"
REMOTE_SCRIPT="$SCRIPT_DIR/remote/tap-remote.sh"

# Variables needed to connect to server
USER=''
REMOTE_HOST=''
REMOTE_PORT=''
REMOTE_APP_BASE=''

# Function to execute is assembled by script parameter.
#  All functions which should be called by a user, should
#  have this format: 'tap-<functionname>'
# E.g:
#   ./tap help
#  calls the function 'tap-help'
tapCommandName=$1
tapCommand="tap-$tapCommandName"
tapCommandParams=${@:2}

function tap-help() {
    echo 'usage: tap <command> [<args>]'
    echo ''
    echo '  apps                               List all applications'
    echo '  upload <app-name> <artifact-name>  Upload new application'
    echo '  delete <app-name>                  Delete application'
    echo '  start <app-name>                   Start application'
    echo '  stop <app-name>                    Stop application'
    echo '  env <app-name> run                 Show run script of the application'
    echo '  env <app-name> vars                Show variables of the application'
    echo '  set-env <app-name> <env-file>      Uses <env-file> as environment file for the application'
    echo '  logs <app-name>                    Show log of the application'
    echo '  logs <app-name> tail               Show live log of the application'
}

function executeRemote() {
    params="$@"
    ssh -p "$REMOTE_PORT" "$USER@$REMOTE_HOST" "bash -s" -- < "$REMOTE_SCRIPT" "$params"
}

function tap-apps() {
    executeRemote tap-apps
}

function readConfigValues() {
    # Not so fast, because file is read a few times
    USER=`awk -F "=" '/^user/{print $2}' "$CONFIG_FILE"`
    REMOTE_HOST=`awk -F "=" '/^remoteHost/{print $2}' "$CONFIG_FILE"`
    REMOTE_PORT=`awk -F "=" '/^remotePort/{print $2}' "$CONFIG_FILE"`
    REMOTE_APP_BASE=`awk -F "=" '/^remoteAppBase/{print $2}' "$CONFIG_FILE"`
}

function functionNameExist() {
    local functionName=$1
    local typeOfFunction=`type -t "$functionName"`
    if [ "$typeOfFunction" = "function" ]; then
        echo true
    else
        echo false
    fi
}


functionExist=`functionNameExist "$tapCommand"`
if [ "$functionExist" = true ]; then
    # Config values has to be set before the correct function is called
    readConfigValues
    "$tapCommand" "$tapCommandParams"
else
    echo 'Unknown command'
    echo ''
    tap-help
    exit 1
fi
