#!/bin/bash



### Load configuration
CONFIG_FILE="`dirname $0`/stale-request-hunter.conf.defaults"
if [ ! -e $CONFIG_FILE ]; then
    echo "ERROR: Default config file not found: $CONFIG_FILE"
    exit 1
fi
. $CONFIG_FILE

CONFIG_FILES='stale-request-hunter.conf.site stale-request-hunter.conf.local'
for CONFIG_FILE in $CONFIG_FILES; do
    if [ -e $CONFIG_FILE ]; then
	. $CONFIG_FILE
    fi
done



### Parse command line arguments
COMMIT='false'
if [ "$1" == "commit" ]; then
    COMMIT='true'
fi



### Get active requests
ACTIVE_REQUESTS=`lynx -dump -width=1000 $HTTPD_STATUS_URI | grep ' W ' | grep '/' | awk '{print $6,$2,$11,$12,$13,$14}' | eval $EXCLUDE_CMD_DEFAULT | eval $EXCLUDE_CMD_SITE | eval $EXCLUDE_CMD_LOCAL`
#echo "$ACTIVE_REQUESTS"
#exit



### Loop throught requests and decide what to do with each
printf %s "$ACTIVE_REQUESTS" | while IFS= read -r REQ; do

    REQ_TIME=`echo $REQ | awk '{print $1}'`
    REQ_PID=`echo $REQ | awk '{print $2}'`
    REQ_INFO=`echo $REQ | awk '{print $3,$4,$5,$6}'`
#    echo "$REQ_TIME"
#    echo "$REQ_PID"
#    echo "$REQ_INFO"

    if [ "$REQ_TIME" -gt "$STALE_REQUEST_TIMEOUT" ]; then
	if [ "$COMMIT" == "true" ]; then
	    echo "Killing Apache HTTPD child pid $REQ_PID ($REQ_TIME seconds serving $REQ_INFO)"
	    kill -15 $REQ_PID
	else
	    echo "DEBUG MODE: NOT Killing Apache HTTPD child pid $REQ_PID ($REQ_TIME seconds serving $REQ_INFO)"
	fi
    fi
done
