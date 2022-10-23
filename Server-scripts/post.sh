#!/bin/bash
###################################################################################
#
#  Veeam - post-script for Sierra ILS (Innovative)
#
###################################################################################

. ./common.sh

function restart_control_program_after_backup() {
  BACKUP_PREPARE_STATUS=$(tail -1 $LOG_FILE | grep -e ERROR)
  echo "Backup prepare status " $BACKUP_PREPARE_STATUS
  log_message 'INFO' 'Attempting restart of control program.'

  if [[ $BACKUP_PREPARE_STATUS -ne 0 ]]
  then
    log_message 'WARNING' "Backup prepare failed. Continuing with iiictl backup fail."
    restore_param="fail"
  else
    log_message 'INFO' 'Backup prepare was successful. Continuing with iiictl backup success.'
    restore_param="success"
  fi

  restore_from_backup $restore_param
}

function restore_from_backup() {

  restore_cmd="${III_CMD} backup $1"
  log_message 'INFO' "Executing $restore_cmd."
  ${restore_cmd}
  restore_resp="${PIPESTATUS[0]}"

  if [[ $restore_resp -ne 0 ]]
  then
    log_message 'ERROR' "Executing ${restore_cmd} returned ${restore_resp}. Exiting to Veeam with non zero status."
    exit 1
  else
    log_message 'INFO' "Executing ${restore_cmd} returned ${restore_resp} (success). Exiting to Veeam."
    exit 0
  fi
}

# Main body ------------------------
log_message 'INFO' 'Starting post-job script.'
verify_root
restart_control_program_after_backup
