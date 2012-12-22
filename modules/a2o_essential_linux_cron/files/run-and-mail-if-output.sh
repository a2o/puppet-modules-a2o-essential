#!/bin/bash
###########################################################################
# a2o Essential Puppet Modules                                            #
#-------------------------------------------------------------------------#
# Copyright (c) Bostjan Skufca                                            #
#-------------------------------------------------------------------------#
# This source file is subject to version 2.0 of the Apache License,       #
# that is bundled with this package in the file LICENSE, and is           #
# available through the world-wide-web at the following url:              #
# http://www.apache.org/licenses/LICENSE-2.0                              #
#-------------------------------------------------------------------------#
# Authors: Bostjan Skufca <my_name [at] a2o {dot} si>                     #
###########################################################################



### Check parameters
if [ "$#" != "2" ]; then
        echo "ERROR: Invalid number of arguments, 2 required."
        echo "USAGE: $0 \"command to run\" \"mails@to notify@on error@domain\""
        exit 1
fi
COMMAND=$1
EMAIL_ADDRESSES=$2



### Run the command
COMMAND_OUTPUT=`$COMMAND 2>&1`
COMMAND_STATUS=$?



### Notify on error
if [ "$COMMAND_STATUS" != "0" ]; then
        echo "$COMMAND_OUTPUT" | mail -s "$COMMAND" $EMAIL_ADDRESSES
        exit 1
fi



### Notify on output
if [ "$COMMAND_OUTPUT" != "" ]; then
        echo "$COMMAND_OUTPUT" | mail -s "$COMMAND" $EMAIL_ADDRESSES
        exit 2
fi
