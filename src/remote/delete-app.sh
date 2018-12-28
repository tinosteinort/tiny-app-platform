#!/bin/bash

set -e

appbase=$1
appname=$2

cd $appbase

if [ -x $appname ]
then
    rm -r $appname
else
    echo "'$appname' does not exist"
fi
