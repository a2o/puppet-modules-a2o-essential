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



# Include configuration
. `dirname $0`/dump.config.defaults
if [ -e `dirname $0`/dump.config.site ]; then
    . `dirname $0`/dump.config.site
fi
if [ -e `dirname $0`/dump.config.local ]; then
    . `dirname $0`/dump.config.local
fi



# Required parameter - destination directory
DESTDIR="$1"

# Check if directory exists
if [ "$DESTDIR" == "" ]; then
    echo "ERROR: Usage: $0 destdir [-q|--quiet]"
    exit 1
elif [ ! -e $DESTDIR ]; then
    mkdir -p $DESTDIR
elif [ ! -d $DESTDIR ]; then
    echo "ERROR: Destination is not a directory: $DESTDIR"
    exit 1
fi

# Strip trailing slash
DESTDIR=`echo "$DESTDIR" | sed -e 's/\/$//'`



# Get verbosity argument
if [ "$2" == '-q' ] || [ "$2" == '--quiet' ]; then
    VERBOSE_OUTPUT="no"
else
    VERBOSE_OUTPUT="yes"
fi



# Define output function
_echo() {
    if [ "$VERBOSE_OUTPUT" == "yes" ] || [ "$ERROR_OCCURED" == "yes" ]; then
	if [ "$1" == "-n" ]; then 
	    echo -n "$2"
	else
	    echo "$1"
	fi
    fi
}



# Signal start time
_echo "Starting at `date`"



# Check for stale running backup transfer process
PIDFILE="$DESTDIR/dump.mysql.sh.pid"
_echo -n "Writing own pid to lockfile $PIDFILE... "
if [ -e $PIDFILE ]; then
    echo "old pid file found - another dump.mysql.sh process exists?"
    OLDPID=`cat $PIDFILE`
    if [ "`psfind ^$OLDPID`" == "" ]; then
	echo "  Process with pid $OLDPID from stale pidfile $PIDFILE does not exist - removing"
	rm $PIDFILE
    elif [ "`psfind ^$OLDPID | grep dump.mysql.sh`" == "" ]; then
	echo "  Process with pid $OLDPID is not a backup transfer process - removing stale pidfile"
	rm $PIDFILE
    else
	_echo "Yes, exiting..."
	exit 1
    fi
fi



# Put own pid into lock file
PID=$$
echo $PID > $PIDFILE
_echo "done."



# Remove old backup
_echo -n "Removing old backup... "
rm -f $DESTDIR/*.sql
rm -f $DESTDIR/*.sql.$COMPRESS_EXT
_echo "done."
_echo



# Error signal
ERROR_OCCURED="no"



# Get database list
DBS_ALL=`echo 'SHOW DATABASES' | $MYSQL --defaults-file=$MYCNF -Bs`;
if [ "$?" != "0" ]; then
    ERROR_OCCURED="yes"
fi

# Parse which DBS are included
DBS_INCLUDED=""
for DB in $DBS_ALL; do
    RES=`echo "$DB" | grep "$INCLUDE_DBS" | grep -c .`
    if [ "$RES" == "0" ]; then
	_echo "Not including database: $DB"
	continue
    fi
    DBS_INCLUDED="$DBS_INCLUDED $DB"
done

# Parse which DBS are EXCLUDED
DBS=""
for DB in $DBS_INCLUDED; do
    RES=`echo "$DB" | grep "$EXCLUDE_DBS" | grep -c .`
    if [ "$RES" == "1" ]; then
	_echo "Excluding database:     $DB"
	continue
    fi
    DBS="$DBS $DB"
done
_echo



### Pause replication slave if requested
SLAVE_PAUSED=0
if [ "$PAUSE_SLAVE" == "1" ]; then

    # Check if replication is running at all
    RES=`echo "SHOW SLAVE STATUS\G" | $MYSQL | grep -c .`
    if [ "$RES" == "0" ]; then
	echo "WARNING: Replication is not configured at all!"
	ERROR_OCCURED="yes"
    else
        RES=`echo "SHOW SLAVE STATUS\G" | $MYSQL | grep Running | grep -v ': Yes$' | grep -c .`
	if [ "$RES" != "0" ]; then
	    echo "WARNING: Replication is not running properly!"
	    ERROR_OCCURED="yes"
	else
	    _echo "REPLICATION: Pausing..."
    	    RES=`echo "STOP SLAVE" | $MYSQL`
    	    SLAVE_PAUSED=1
	fi
    fi
fi



# Loop trough DBS and dump
for DB in $DBS; do

    # What destination will it end in?
    DESTFILE=$DESTDIR/$DB.sql
    if [ "$COMPRESS" == "1" ]; then
	DESTFILE_CMD="$COMPRESS_CMD"
	DESTFILE="$DESTFILE.$COMPRESS_EXT"
    else
	DESTFILE_CMD="cat"
	DESTFILE="$DESTFILE"
    fi

    # Dump it
    _echo -n "DUMP: $DB... "
    umask $DESTINATION_UMASK
    touch $DESTFILE
    $MYSQLDUMP --defaults-file=$MYCNF $MYSQLDUMP_OPTS $DB | LANG=C grep -v '^-- Dump completed on ' | $DESTFILE_CMD > $DESTFILE

    # Check for error
    if [ "$?" != "0" ]; then
	ERROR_OCCURED="yes"
	echo "ERROR"
    else
	_echo "done."
    fi
done



### Resuming replication
if [ "$SLAVE_PAUSED" == "1" ]; then

    _echo "REPLICATION: Saving replication coordinate (index) files... "
    rm -f $DATADIR/*.index && cp $MYSQL_DATADIR/*.index $DESTDIR/
    rm -f $DATADIR/*.info  && cp $MYSQL_DATADIR/*.info  $DESTDIR/

    _echo "REPLICATION: Resuming... "
    RES=`echo "START SLAVE" | $MYSQL`
fi
echo



# Remove pid file
_echo -n "Removing lock file... "
rm $PIDFILE
_echo "done."



# Signal end time
_echo "Finishing at `date`"
_echo



# If error has occured, signal it
if [ "$ERROR_OCCURED" != "no" ]; then
    echo "WARNING: Error occured while dumping databases"
    exit 2
fi
