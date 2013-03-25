#!/bin/bash



###
### Sanity check
###
if [ "$DEST_ROOT" == "" ]; then
    echo "Hint:  export DEST_ROOT='/mnt/newroot'"
    echo "ERROR: Destination root path not specified."
    exit 1
fi



###
### Generate
###
DEST_FILE="${DEST_ROOT}/var/spool/cron/crontabs/root" &&
cat > $DEST_FILE <<-EOF
### System cron jobs
47 * * * * /usr/bin/run-parts /etc/cron.d/hourly  1> /dev/null
40 3 * * * /usr/bin/run-parts /etc/cron.d/daily   1> /dev/null
30 3 * * 0 /usr/bin/run-parts /etc/cron.d/weekly  1> /dev/null
20 3 1 * * /usr/bin/run-parts /etc/cron.d/monthly 1> /dev/null
EOF



echo
echo "OK: Root's crontab has been generated."
echo
