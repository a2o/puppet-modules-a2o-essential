#!/bin/bash



###
### Sanity check
###
if [ "$DEST_ROOT" == "" ]; then
    echo "Hint:  export DEST_ROOT='/mnt/newroot'"
    echo "ERROR: Destination root path not specified."
    exit 1
fi
DEST_FILE="$DEST_ROOT/etc/rc.d/rc.inet1.conf"
DEST_FILE_ORIG="$DEST_FILE.orig"



###
### Backup original network configuration file /etc/rc.d/rc.inet1.conf, but only once
###
if [ ! -f $DEST_FILE_ORIG ]; then
    cp $DEST_FILE $DEST_FILE_ORIG
else
    echo "WARNING: File already exists, skipping backup: $DEST_FILE_ORIG"
fi



###
### Get networking information
###
IPADDR=`ifconfig eth0 | grep 'inet addr:' | head -n1 | awk '{print $2}' | cut -d':' -f2` &&
NETMASK=`ifconfig eth0 | grep 'inet addr:' | head -n1 | awk '{print $4}' | cut -d':' -f2` &&
GATEWAY=`route -n | grep '^0.0.0.0' | awk '{print $2}'` &&
if [ "$NEW_HOSTNAME" != "" ]; then
    FQDN="$NEW_HOSTNAME"
else
    FQDN=`hostname -f`
fi &&
HOSTNAME_SHORT=`echo "$FQDN" | cut -d'.' -f1` &&


###
### Update /etc/rc.d/rc.inet1.conf
###
cat $DEST_FILE_ORIG \
| sed -e "s/^IPADDR\[0\]=\"\"/IPADDR[0]=\"$IPADDR\"/" \
| sed -e "s/^NETMASK\[0\]=\"\"/NETMASK[0]=\"$NETMASK\"/" \
| sed -e "s/^GATEWAY=\"\"/GATEWAY=\"$GATEWAY\"/" \
> $DEST_FILE &&



###
### Copy /etc/resolv.conf
###
cp /etc/resolv.conf $DEST_ROOT/etc/resolv.conf &&



###
### Generate /etc/HOSTNAME and /etc/hosts
###
echo "$FQDN" > $DEST_ROOT/etc/HOSTNAME &&
cat > $DEST_ROOT/etc/hosts <<-EOF
127.0.0.1   localhost.localnet localhost

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters

$IPADDR   $FQDN $HOSTNAME_SHORT
EOF



###
### Check status
###
RES=$?
if [ "$RES" != "0" ]; then
    echo
    echo "ERROR: An error has occured while configuring networking. Please inspect the output above."
    echo
    exit $RES
fi



echo
echo "OK: Network configured."
echo
