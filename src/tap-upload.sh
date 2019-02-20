#!/bin/bash

set -e

SCRIPT_DIR="$(cd `dirname $0` && pwd)"
. "$SCRIPT_DIR/tap.cfg"
. "$SCRIPT_DIR/utils.sh"

appName=$1
artifactName=$2

checkIfArtifactIsFolder() {
    if [[ ! -d "$artifactName" ]]
    then
        echo "Could not upload application"
        echo "Expected is a directory, but '$artifactName' is no directory"
        exit 1
    fi
}

checkIfRunScriptExist() {
    local runScript="$artifactName/run.sh"
    if [[ ! -x "$runScript" ]]
    then
        echo "Could not upload application"
        echo "Requires an executable file 'run.sh' which starts the application"
        exit 1
    fi
}

checkIfArtifactIsFolder
checkIfRunScriptExist

echo "Prepare '$appName' on remote host"
execScriptRemote "$SCRIPT_DIR/remote/init-or-update-app.sh" "$remoteAppBase" "$appName"

echo "upload '$artifactName' as '$appName'"
scp -P "$remotePort" -r "$artifactName/" "$user@$remoteHost:$remoteAppBase/$appName/$artifactName"
execRemote "mv $remoteAppBase/$appName/$artifactName $remoteAppBase/$appName/bin"
