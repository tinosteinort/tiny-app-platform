#!/bin/bash

set -e

SCRIPT_DIR="$(cd `dirname $0` && pwd)"
. "$SCRIPT_DIR/tap.cfg"
. "$SCRIPT_DIR/utils.sh"

appname=$1

execScriptRemote "$SCRIPT_DIR/remote/start-app.sh" "$remoteAppBase" "$appname"