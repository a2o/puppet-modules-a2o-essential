#!/bin/bash

echo 'SHOW FULL PROCESSLIST' | mysql > /var/mysql/log/processlist_logs/processlist-`date +%H:%M`
