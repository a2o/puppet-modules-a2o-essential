#!/bin/bash



###
### Remove OpenSSL
###

# Remove distro-installed openssl-solibs
if [ -f /etc/slackware-version ]; then
    if [ -f /var/log/packages/openssl-solibs-* ]; then
	removepkg openssl-solibs
    fi
fi &&

# Create symlinks?
ln -sf /usr/local/openssl-init/lib/libssl.so.1.0.0 /usr/lib/libssl.so.1.0.0 &&
ln -sf /usr/local/openssl-init/lib/libcrypto.so.1.0.0 /usr/lib/libcrypto.so.1.0.0 &&
ln -sf /usr/local/openssl-init/lib/libssl.so.1.0.0 /usr/lib/libssl.so.1 &&
ln -sf /usr/local/openssl-init/lib/libcrypto.so.1.0.0 /usr/lib/libcrypto.so.1 &&

# Run ldconfig to update cache
ldconfig &&



###
### Check final exit status
###
true
if [ "$?" != "0" ]; then
    echo "ERROR: Unable to remove OpenSSL-solibs"
    exit 1
fi
echo
echo "########## (in chroot) OK: Removal of openssl-solibs has been completed."
echo
