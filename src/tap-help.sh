#!/bin/bash

set -e

echo 'usage: tap <command> [<args>]'
echo ''
echo '  apps                               List all applications'
echo '  upload <app-name> <artifact-name>  Upload new application'
echo '  delete <app-name>                  Delete application'
echo '  start <app-name>                   Start application'
echo '  stop <app-name>                    Stop application'
echo '  env <app-name> run                 Show run script of the application'
echo '  env <app-name> vars                Show variables of the application'
echo '  set-env <app-name> <env-file>      Uses <env-file> as environment file for the application'
echo '  logs <app-name>                    Show log of the application'
echo '  logs <app-name> tail               Show live log of the application'
