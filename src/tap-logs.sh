#!/bin/bash

set -e

SCRIPT_DIR="$(cd `dirname $0` && pwd)"
. "$SCRIPT_DIR/tap.cfg"
. "$SCRIPT_DIR/utils.sh"

appname=$1
logparam=$2

execScriptRemoteWithTerminal "$SCRIPT_DIR/remote/app-logs.sh" "$remoteAppBase" "$appname" "$logparam"
