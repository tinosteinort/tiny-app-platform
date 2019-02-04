# TODOs
[ ] If there are no apps, `tap apps` shows at least one line with `*    - not started`
[X] `tap stop <appname>` does not work correctly for a sample embedded tomcat java application.
    * PID file is removed
    * but application is still running.
    * consider: `kill -9` ?
    * [X] Maybe it is a problem because the tomcat is running
[X] new commands:
        [X] tap log <appname>       -> cat logs.txt
        [X] tap log <appname> tail  -> tail -f logs.txt

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
