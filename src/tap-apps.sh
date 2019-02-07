#!/bin/bash

set -e

SCRIPT_DIR="$(cd `dirname $0` && pwd)"
. "$SCRIPT_DIR/tap.cfg"
. "$SCRIPT_DIR/utils.sh"

execScriptRemote "$SCRIPT_DIR/remote/list-apps.sh" "$remoteAppBase"
