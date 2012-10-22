#!/bin/bash

#
# Info:
#   This script is intended to be run as postrun_command in puppet agent config.
#   It checks the last (from previous run) run summary yaml and if that run was
#   without errors, it copies the file to $STATE_DIR/last_successful_run_summary.yaml,
#   preserving file c and mtime. This is intended to be then checked by Nagios/NRPE.
#
#   It will never return non-zero status, because if we do so, it will fail the
#   whole puppet run.
#



### Get puppet state dir
STATE_DIR="/var/lib/puppet-sys/state"
if [ "x$1" != "x" ]; then
    STATE_DIR="$1"
fi
STATE_FILE="$STATE_DIR/last_run_summary.yaml"
STATE_FILE_SUCCESS="$STATE_DIR/last_run_summary.yaml.success"



################################################################################
### Start Checks
################################################################################

# Check if file exists
if [ ! -f $STATE_FILE ]; then
    echo "WARNING: State file of previous run does not exist: $STATE_FILE"
    exit
fi

# Check number of resources managed
RESOURCES_COUNT=`cat $STATE_FILE | grep '^ *resources: *$' -A8 | grep 'total:' | awk '{print $2}'`
if [ "$RESOURCES_COUNT" -eq "0" ]; then
    echo "WARNING: Zero resources managed"
    exit
fi

# Check number of failed resources
FAILED_COUNT=`cat $STATE_FILE | grep 'fail' | grep -v '0' | grep -c .`
if [ "$FAILED_COUNT" -gt "0" ]; then
    echo "WARNING: Some resources have failed"
    exit
fi

################################################################################
### End Checks
################################################################################



### Copy the file
cp --preserve=all $STATE_FILE $STATE_FILE_SUCCESS
