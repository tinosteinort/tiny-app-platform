#!/bin/bash

set -e

SCRIPT_DIR="$(cd `dirname $0` && pwd)"
. "$SCRIPT_DIR/tap.cfg"
. "$SCRIPT_DIR/utils.sh"

appname=$1
envtype=$2

cmd="$SCRIPT_DIR/remote/env-app-$envtype.sh"

if [[ -x $cmd ]]
then
    execScriptRemote "$cmd" "$remoteAppBase" "$appname"
else
    echo 'Unknown command'
    echo ''
    "$SCRIPT_DIR/tap-help.sh"
    exit 1
fi
