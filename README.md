tap - tiny application platform
===============================

This tool should help to simply distribute applications to a raspberry pi and provide a simple lifecycle management.


# Functions
```
usage: tap <command> [<args>]

  apps                               List all applications
  upload <app-name> <artifact-name>  Upload new application
  delete <app-name>                  Delete application
  start <app-name>                   Start application
  stop <app-name>                    Stop application
  env <app-name> run                 Show run script of the application
  env <app-name> vars                Show variables of the application
  set-env <app-name> <env-file>      Uses <env-file> as environment file for the application
```


# Explanation

### What is an application in this scope?
An application is a folder which contains the application artifacts and an executable file `run.sh`,
which starts the application.

### Environment
With the `set-env` command, you can define environment variables which are accessible by the run script
or by your application. The environment parameters *will not* be overwritten, when you upload your application
for an update.

Define variables in the following way (don't miss the 'export'):
```
export VAR_NAME="VALUE"
```

### Background
This tool is just a bunch of shell scripts on the client. All the work is done via `ssh` and `scp`. On the
server side, there are just the application artifacts and some needed config files, which are created for the
purpose.


# Installation

### Put into path
Add the `src/` directory to the `PATH`.

### Configure `tap`
You have to configure some values in the file `src/tap.cfg`
* `user`: the ssh user
* `remoteHost`: the host to connect to
* `remoteAppBase`: the folder in wich all the applications should be stored

### Prepare your SSH environment on your server
You have to authorize your ssh key on your raspberry:
```
ssh-copy-id -i ~/.ssh/<mykey> <user>@<host>
```

### Simplify usage on client side
To get this thing running `ssh` and `scp` is used multiple times for a command. So, to not enter
the credentials every time, enter your credentials for the ssh-agent:
```
ssh-add
```

If there is no running ssh-agent, start it before with (and `ssh-add` again):
```
eval "$(ssh-agent)"
```


# Environment / Use Case

* Bash on client side (should also work with Windows Subsystem for Linux)
* Raspberry Pi in local network
* as a developer I want to deploy and manage my own application on the raspberry
* I want to use my windows notebook to `upload`, `start`, `stop`, ... applications on the raspberry
* I don't want to `ssh` every time to the raspberry to do this stuff


# Ideas / Notes while Implementation

* start script per application needed
* needed parameters of the app must be defined somehow (part of the application code?)
* save parameter (should be able to stop and start the application without querying for params)
* when application is started, write PID into a file
* when the tool should check which apps are running, the PID file can be used to check if there is a running
  process with this PID
* Username and password is required for the remote commands
    * to not enter password every time, use ssh agent
    * certificate is needed on raspberry
    * publish certificate to raspberry:
        > ssh-copy-id -i ~/.ssh/mykey user@host
    * before using any `tap` command, run `ssh-add`
