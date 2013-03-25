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
### Change dir to destination root directory
###
cd $DEST_ROOT
RES="$?"
if [ "$RES" != "0" ]; then
    echo "ERROR: Unable to chdir to '$DEST_ROOT'"
    exit 1
fi



###
### Cleanup in /etc
###
rm -rf ./etc/X11
rm -rf ./etc/cron.daily
rm -rf ./etc/cron.hourly
rm -rf ./etc/cron.monthly
rm -rf ./etc/cron.weekly
rm -rf ./etc/logrotate.d
rm -rf ./etc/modprobe.d
rm -rf ./etc/profile.d/*.csh
rm -rf ./etc/rc0.d
rm -rf ./etc/rc1.d
rm -rf ./etc/rc2.d
rm -rf ./etc/rc3.d
rm -rf ./etc/rc4.d
rm -rf ./etc/rc5.d
rm -rf ./etc/rc6.d
rm -rf ./etc/rc.d/rc?.d
rm -rf ./etc/rc.d/rc.4
rm -rf ./etc/rc.d/rc.ip_forward
rm -rf ./etc/rc.d/rc.klogd
rm -rf ./etc/rc.d/rc.local
rm -rf ./etc/rc.d/rc.modules*
rm -rf ./etc/rc.d/rc.rpc
rm -rf ./etc/rc.d/rc.serial
rm -rf ./etc/rc.d/rc.syslog
rm -rf ./etc/rc.d/rc.syslogd
rm -rf ./etc/rc.d/rc.sysvinit
rm -rf ./etc/skel/*
rm -rf ./etc/skel/.xsession
rm -rf ./etc/udev/rules.d/70-persistent-cd.rules
rm -rf ./etc/udev/rules.d/70-persistent-net.rules
rm -rf ./etc/csh.login
rm -rf ./etc/fb.modes
rm -rf ./etc/hosts.equiv
rm -rf ./etc/modprobe.conf
rm -rf ./etc/nntpserver
rm -rf ./etc/printcap
rm -rf ./etc/rpc
rm -rf ./etc/scsi_id.config
rm -rf ./etc/serial.conf
rm -rf ./etc/syslog.conf
rm -rf ./etc/wgetrc



###
### Cleanup in /usr
###
rm -rf ./usr/local/games
rm -rf ./usr/lib64/libz*



###
### Cleanup in /var
###
rm -rf ./var/X11
rm -rf ./var/X11R6
rm -rf ./var/rwho



###
### Cleanup complete.
###
echo
echo "OK: Cleanup complete. Please continue with OS configuration."
echo
