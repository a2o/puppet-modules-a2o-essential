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



### Get parameters from command line
NTP_SERVER="pool.ntp.org"
MAX_DIFF_SECONDS="10"
if [ "x$1" != "x" ]; then
    if [[ "$1" =~ ^[0-9]+$ ]]; then
	MAX_DIFF_SECONDS=$1
    else
        echo "ERROR: Invalid argument MAX_DIFF_SECONDS: $1"
        exit 1
    fi
fi



### Get program locations
HWCLOCK=/sbin/hwclock
if [ -x /usr/local/bin/sntp ]; then
    CLIENT_MODE="sntp"
    SNTP="/usr/local/bin/sntp"
elif [ -x /usr/bin/sntp ]; then
    CLIENT_MODE="sntp"
    SNTP="/usr/bin/sntp"
elif [ -x /usr/local/bin/ntpdate ]; then
    CLIENT_MODE="ntpdate"
    NTPDATE="/usr/local/bin/ntpdate"
elif [ -x /usr/sbin/ntpdate ]; then
    CLIENT_MODE="ntpdate"
    NTPDATE="/usr/sbin/ntpdate"
else
    echo "ERROR: Unable to find stnp or ntpdate"
    exit 1
fi



### Sleep for n seconds
SLEEP_SECONDS=`expr $RANDOM \* 60 / 32768`
echo "INFO: Sleeping for $SLEEP_SECONDS seconds to ease the load on pool.ntp.org..."
sleep $SLEEP_SECONDS



### Get whole number of seconds of time desync between this system and NTP server
if [ "$CLIENT_MODE" == "sntp" ]; then

    DIFF_SECONDS=`$SNTP $NTP_SERVER | cut -d' ' -f6 | sort -n | grep -v sntp | awk '{sum+=$1} END { print sum/NR}' | cut -d'.' -f1`
    if [ "$?" != 0 ]; then
	echo "ERROR: unable to parse sntp output"
	exit 1
    fi

elif [ "$CLIENT_MODE" == "ntpdate" ]; then

    NTPDATE_Q_RES=`$NTPDATE -q $NTP_SERVER | tail -n1 | grep '\(adjust\|step\) time server'`
    if [ "$?" != 0 ]; then
	echo "ERROR: ntpdate output did not contain line with 'adjust/step time server'"
	exit 1
    fi

    echo "$NTPDATE_Q_RES" | grep -Eo 'offset [+-]?[0-9]+\.[0-9]+ sec$' > /dev/null 2>&1
    if [ "$?" != 0 ]; then
        echo "ERROR: Unable to find pattern 'offset X sec' in ntpdate output"
        exit 1
    fi

    DIFF_SECONDS=`echo "$NTPDATE_Q_RES" | grep -Eo 'offset [+-]?[0-9]+\.[0-9]+ sec$' | sed -e 's/offset [+-]\?//' | sed -e 's/\.[0-9]\+ sec//'`

else

    echo "ERROR: Internal bug, unknown client mode: $CLIENT_MODE"
    exit 1

fi



### Check if we really have a int digit
if [[ "$DIFF_SECONDS" =~ ^[0-9]+$ ]]; then
    echo -n
else
    echo "ERROR: Unable to parse out seconds of difference: '$NTPDATE_Q_RES'"
    exit 1
fi



### If less than MAX_DIFF_SECONDS seconds of difference, ignore it and rely on ntpd to even it out
if [ "$DIFF_SECONDS" -lt $MAX_DIFF_SECONDS ]; then
    echo "Difference is less than $MAX_DIFF_SECONDS seconds, let's leave ntpd to work this out. Exiting..."
    exit 0
else
    echo "WARNING: Clock difference between this system and pool.ntp.org is more than $MAX_DIFF_SECONDS seconds."
    echo "NOTICE:  Forcibly adjusting by stopping ntpd and executing ntpdate... "
fi



### Which command to use to manage ntpd?
if [ -x /etc/rc.d/rc.ntpd ]; then
    NTPD_START='/etc/rc.d/rc.ntpd start'
    NTPD_STOP='/etc/rc.d/rc.ntpd stop'
elif [ -x /etc/init.d/ntpd ]; then
    NTPD_START='/etc/init.d/ntpd start'
    NTPD_STOP='/etc/init.d/ntpd stop'
elif [ -f /etc/init/ntp ]; then
    NTPD_START='service ntp start'
    NTPD_STOP='service ntp stop'
else
    echo "ERROR: Unable to detect ntpd start and stop command"
    exit 1
fi



### Manage it
# We have to stop ntpd to free the socket
$NTPD_STOP
$NTPDATE pool.ntp.org
$NTPD_START



### Exit with non-zero so email with warning may be sent when forced sync situation arises
exit 1
