tap - tiny application platform
===============================

This tool should help to simply distribute applications to a raspberry pi.

# Environment / Use Case

* Windows Notebook with activated WSL (Windows Subsystem for Linux) - `bash` is available
* Raspberry Pi in local network
* as a developer I want to deploy and manage my own application on the raspberry
* I want to use my windows notebook to `upload`, `start`, `stop`, ... applications on the raspberry
* I don`t want to `ssh` every time to the raspberry to do this stuff

# What is an application?

An application is a folder which contains the application artifacts and an executable file `run.sh`,
which starts the application.

# Functions
```
usage: tap <command> [<args>]

  apps                               List all applications
  upload <app-name> <artifact-name>  Upload new application
  delete <app-name>                  Delete application
  start <app-name>                   Start application
  stop <app-name>                    Stop application
  env <app-name>                     Show start script of the application
```

# Hints

You have to authorize your ssh key on your raspberry:
```
ssh-copy-id -i ~/.ssh/<mykey> <user>@<host>
```

To get this thing running `ssh` and `scp` is used multiple times for a command. So, to not enter
the credentials every time, enter your credentials for the ssh-agent:
```
ssh-add
```

If there is no running ssh-agent, start it before with (and `ssh-add` again):
```
`eval $(ssh-agent)`
```

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
