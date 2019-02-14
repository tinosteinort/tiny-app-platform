#!/bin/bash

set -e

SCRIPT_DIR="$(cd `dirname $0` && pwd)"
. "$SCRIPT_DIR/tap.cfg"
. "$SCRIPT_DIR/utils.sh"

appname=$1
logparam=$2

if [[ "$logparam" = "tail" ]]
then
    # If there is no pseudo tty, the tail process will not be cancelled when the ssh process is cancelled
    execScriptRemoteWithTerminal "$SCRIPT_DIR/remote/app-logs-tail.sh" "$remoteAppBase" "$appname" "$logparam"
else
    # If a normal 'cat' would be executed within a pseudo terminal, the user is on the remote machine after
    #  finishing the 'cat' command. So use execScriptRemote without terminal
    execScriptRemote "$SCRIPT_DIR/remote/app-logs.sh" "$remoteAppBase" "$appname" "$logparam"
fi
