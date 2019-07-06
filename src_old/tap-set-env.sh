#!/bin/bash

set -e

SCRIPT_DIR="$(cd `dirname $0` && pwd)"
. "$SCRIPT_DIR/tap.cfg"
. "$SCRIPT_DIR/utils.sh"

appname=$1
envfile=$2

if [[ ! -e $envfile ]]
then
    echo "'$envfile' does not exist"
    exit 1
fi

scp -P "$remotePort" "$envfile" "$user@$remoteHost:$remoteAppBase/$appname/environment.cfg"
