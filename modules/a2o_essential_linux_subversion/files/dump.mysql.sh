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



# File paths, change this if it can't be autodetected via which command
MYSQL="mysql"
MYSQLDUMP="mysqldump"
SKIP_DBS="^\(information_schema\|test\)\$"
MYCNF="/root/.my.cnf.backup"



# Additional parameter - destination directory
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
cd $DESTDIR && rm *.sql.bz2
_echo "done."



# Error signal
ERROR_OCCURED="no"



# Get database list
DBS=`echo 'SHOW DATABASES' | $MYSQL --defaults-file=$MYCNF -Bs`;
if [ "$?" != "0" ]; then
    ERROR_OCCURED="yes"
fi



# Loop trough DBS
for DB in $DBS; do

    # Do we have to skip it
    RES=`echo "$DB" | grep "$SKIP_DBS" | grep -c .`
    if [ "$RES" == "1" ]; then
	_echo "  Skipping database $DB."
	continue
    fi

    # Dump it
    _echo -n "  Dumping database $DB... "
    DESTFILE=$DESTDIR/$DB.sql.bz2
    umask 0066
    touch $DESTFILE
    $MYSQLDUMP --defaults-file=$MYCNF --force --add-locks --disable-keys --extended-insert --quote-names --routines --single-transaction --triggers $DB | grep -v '^-- Dump completed on ' | bzip2 -c > $DESTFILE

    # Check for error
    if [ "$?" != "0" ]; then
	ERROR_OCCURED="yes"
	echo "ERROR"
    else
	_echo "done."
    fi
done



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
