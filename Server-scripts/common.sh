#!/bin/bash
###################################################################################
#
#  Helper functions for Veeam pre/post scripts for Sierra ILS (Innovative)
#
###################################################################################

III_CMD='/usr/sbin/iiictl'
LOG_FILE="/var/log/Veeam.Sierra.log"

# Verify script is running as a user w/ root privileges
function verify_root() {
  if [[ $(id -u) -ne 0 ]]
    then
      log_message 'CRITICAL' 'Script running w/o root privileges'
      exit 1
    else
      log_message 'INFO' 'Script running w/ root privileges'
  fi
}

# Log message
function log_message() {
 echo `date +"%F %T,%3N"` $1"  "$2>>$LOG_FILE
}