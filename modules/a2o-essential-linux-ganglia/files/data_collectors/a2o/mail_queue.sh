#!/bin/sh



### Settings
MAILQ_COMMAND='mailq'



### Get number of messages from postfix mailq
MESSAGES_IN_QUEUE=`$MAILQ_COMMAND | egrep '^--|empty'`
QUEUE_NOT_EMPTY=`echo $MESSAGES_IN_QUEUE | grep -c empty`

if [ $QUEUE_NOT_EMPTY -eq 0 ]; then
    QUEUE_SIZE=`echo $MESSAGES_IN_QUEUE | cut -f5 -d" "`
else
    QUEUE_SIZE=0
fi



### Display output
echo $QUEUE_SIZE
