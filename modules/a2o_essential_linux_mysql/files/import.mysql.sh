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



# Linux bin paths, change this if it can't be autodetected via which command
MYSQL="mysql"



# Additional parameter - destination directory
SRCDIR="$1"



# Check if directory exists
if [ "$SRCDIR" == "" ]; then
    echo "ERROR: Usage: $0 srcdir [-v|--verbose]"
    exit 1
elif [ ! -d $SRCDIR ]; then
    echo "ERROR: Source directory does not exists or is not a directory: $SRCDIR"
    exit 1
fi



# Get verbosity argument
if [ "$2" == '-v' ] || [ "$2" == '--verbose' ]; then
    VERBOSE_OUTPUT="yes"
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
PIDFILE="$SRCDIR/import.mysql.sh.pid"
_echo -n "Writing own pid to lockfile $PIDFILE... "
if [ -e $PIDFILE ]; then
    echo "old pid file found - another import.mysql.sh process exists?"
    OLDPID=`cat $PIDFILE`
    if [ "`psfind ^$OLDPID`" == "" ]; then
	echo "  Process with pid $OLDPID from stale pidfile $PIDFILE does not exist - removing"
	rm $PIDFILE
    elif [ "`psfind ^$OLDPID | grep import.mysql.sh`" == "" ]; then
	echo "  Process with pid $OLDPID is not a mysql import process - removing stale pidfile"
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


 
# Get list of files (databases)
FILES=`cd $SRCDIR && ls *.sql`



# Loop trough DBS
ERROR_OCCURED="no"
for FILE in $FILES; do
    _echo -n "  Importing file $FILE... "

    # Get database name
    DB=`echo "$FILE" | sed -e 's/\.sql//'`
    _echo -n "db $DB... "

    # Check if database exists and drop it
    RES=`echo "SHOW DATABASES" | $MYSQL --skip-column-names | grep -c "^$DB\$"`
    if [ "$RES" == "1" ]; then
	echo -n "database exists - dropping... "
	RES=`echo "DROP DATABASE $DB" | $MYSQL`
    elif [ "$RES" == "0" ]; then
	# alles gut
	echo -n ""
    else
	echo "ERROR: Unexpected result: $RES"
	exit 1
    fi

    # Create database
    RES=`echo "CREATE DATABASE $DB" | $MYSQL`

    # Import
    echo -n "importing... "
    cat $SRCDIR/$FILE | $MYSQL --database $DB
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
