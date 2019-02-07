#!/bin/bash

set -e

SCRIPT_DIR="$(cd `dirname $0` && pwd)"
. "$SCRIPT_DIR/tap.cfg"
. "$SCRIPT_DIR/utils.sh"

appname=$1

echo "Do you really want to delete '$appname'?"
echo -n "(y/n): "
read decision

if [[ "$decision" = "y" ]]
then
    execScriptRemote "$SCRIPT_DIR/remote/delete-app.sh" "$remoteAppBase" "$appname"
fi

