#!/bin/bash

set -e

#
# Executes a local script on the remote host
#
execScriptRemote() {

    scriptFile=$1
    params="${@:2}"

    ssh -p "$remotePort" "$user@$remoteHost" "bash -s" -- < "$scriptFile" "$params"
}

#
# Executes a command on the remote host
#
execRemote() {
    command=$1
    ssh -p "$remotePort" "$user@$remoteHost" "$command"
}
