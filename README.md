# Veeam freeze & thaw scripts for Sierra
Veeam Backup &amp; Replication Freeze-Thaw scripts for Sierra (Innovative)



Utilize the Sierra Enterprise Backup API to interface the Sierra machine with Veeam backup. This will prepare the Sierra system for the backup and to bring the system back to its normal state following the backup.

## Usage

1. Create (if not already available) a user w/ sudo privileges on the target server.
2. Set the details of the user as specified in [https://helpcenter.veeam.com/docs/backup/vsphere/credentials_manager_linux.html?ver=120](https://helpcenter.veeam.com/docs/backup/vsphere/credentials_manager_linux.html?ver=120). Select `Elevate account privileges automatically.`
3. Scripts located in `Veeam-scripts` are to be set in `Processing settings >scripts > Linux scripts`, as specified in [https://helpcenter.veeam.com/docs/backup/vsphere/pre_post_scripts.html?ver=120](https://helpcenter.veeam.com/docs/backup/vsphere/pre_post_scripts.html?ver=120). Scripts should be edited and update the target folder. They currently point to a user's home folder.
4. Copy the scripts located in Server-scripts to the location on your server, as specified in `Veeam-scripts`, for ex. the user's home folder.



## Features

- Minimal editing in Veeam settings
- Perform changes to execution logic on the server side, w/o requiring repeated editing of Veeam scripts.
- Detailed logging
```
2022-12-01 01:52:48,911 INFO  Script running w/ root privileges
2022-12-01 01:52:48,919 INFO  Attempting restart of control program.
2022-12-01 01:52:48,921 INFO  Backup prepare was successful. Continuing with iiictl backup success.
2022-12-01 01:52:48,924 INFO  Executing /usr/sbin/iiictl backup success.
2022-12-01 01:52:49,174 INFO  Executing /usr/sbin/iiictl backup success returned 0 (success). Exiting to Veeam.
```

## Log rotation
1. Create `/etc/logrotate.d/veeam` and add the following
```
/var/log/Veeam.Sierra.log {
    weekly
    missingok
    rotate 4
}
```
Test your configuration w/ `logrotate /etc/logrotate.conf --debug`
