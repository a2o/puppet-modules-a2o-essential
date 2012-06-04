#!/bin/bash
###########################################################################
# a2o Essential Puppet Modules                                            #
#-------------------------------------------------------------------------#
# Copyright (c) 2012 Bostjan Skufca                                       #
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
URI="$1"
EMAIL_ADDRESSES="$2"
#TODO third argument
WGET_OPTS="$3"



### Insert artificial random delay
DELAY_S=`echo $[ 0 + $[ RANDOM % 15 ]]`
DELAY_MS=`echo $[ 1 + $[ RANDOM % 1000 ]]`
sleep $DELAY_S
usleep ${DELAY_MS}000



### Run the command
WGET_OUTPUT=`/usr/local/bin/wget -t1 -T10800 -q -O - "$URI" 2>&1`
WGET_STATUS=$?
WGET_OUTPUT_TRIMMED=`echo "$WGET_OUTPUT" | sed -e 's/\s//g'`



### Notify on error
if [ "$WGET_STATUS" != "0" ]; then
    echo "$WGET_OUTPUT" | mail -s "$URI (status=$WGET_STATUS)" $EMAIL_ADDRESSES
    exit 1
fi



### Notify on non-whitespace-only output
if [ "$WGET_OUTPUT_TRIMMED" != "" ]; then
    echo "$WGET_OUTPUT" | mail -s "$URI" $EMAIL_ADDRESSES
    exit 2
fi
