#!/bin/bash

set -e

SCRIPT_DIR="$(cd `dirname $0` && pwd)"
DIST_DIR="$SCRIPT_DIR/dist"

# Cleanup dist directory
rm -rf "$DIST_DIR"
mkdir "$DIST_DIR"

cp -r src/* "$DIST_DIR"

# Command for user should be without '.sh'
# Why not work with .sh extension at all?
#  -> Because of IDE support for special file types.
mv "$DIST_DIR/tap.sh" "$DIST_DIR/tap"

# dist file has to be executable
chmod +x "$DIST_DIR/tap"
