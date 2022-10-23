#!/bin/bash
###################################################################################
#
#  Veeam - pre-script for Sierra ILS (Innovative)
#
###################################################################################

. ./common.sh

function prepare_Sierra_for_backup() {
  backup_prepare_cmd="${III_CMD} backup prepare"
  log_message 'INFO' 'Starting backup prepare.'
  ${backup_prepare_cmd}
  backup_prepare_cmd_resp="${PIPESTATUS[0]}"

  if [[ $backup_prepare_cmd_resp -ne 0 ]]
  then
    log_message 'ERROR' "Backup prepare returned ${backup_prepare_cmd_resp}. Exiting to Veeam with non zero status."
    exit 1
  else
    log_message 'INFO' "Backup prepare returned ${backup_prepare_cmd_resp} (success). Exiting to Veeam."
    exit 0
  fi
}

# Main body ------------------------
log_message 'INFO' 'Starting pre-job script.'
verify_root
prepare_Sierra_for_backup