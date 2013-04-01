#!/bin/bash



###
### Bootstrap environment check
###
if [ "$A2O_REPO_URI" == "" ]; then
    echo "Hint:  export A2O_REPO_URI='https://raw.github.com/a2o/puppet-modules-a2o-essential/master'"
    echo "ERROR: a2o Repository URI not specified."
    exit 1
fi
if [ "$WORK_DIR" == "" ]; then
    echo "Hint:  export WORK_DIR='/root/a2o'"
    echo "ERROR: Working directory not specified."
    exit 1
fi
mkdir -p $WORK_DIR && cd $WORK_DIR &&
rm -f _os_install_functions.sh &&
wget -q --no-check-certificate "$A2O_REPO_URI/bootstrap/os/slackware64/scripts/_os_install_functions.sh" &&
. _os_install_functions.sh &&

# Check environment and exit if error is found
a2oBootstrap_environmentCheck_inChroot || exit 1



###
### Install OpenSSH
###

# Remove distro-installed openssh
if [ -f /etc/slackware-version ]; then
    if [ -f /var/log/packages/openssh-* ]; then
	removepkg openssh
    fi
fi &&

# Download install script
export SOFTWARE_VERSION="6.2p1" &&
export INSTALL_SCRIPT="install-openssh.sh" &&
mkdir -p /var/src/daemons &&
cd       /var/src/daemons &&
a2oBootstrap_download "$A2O_REPO_URI/modules/a2o_essential_linux_openssh/templates/$INSTALL_SCRIPT" &&

# Populate variables
cp install-openssh.sh install-openssh.sh.dist &&
cat install-openssh.sh.dist \
| sed -e 's#<%= compileDir %>#/var/src/daemons#' \
| sed -e "s#<%= softwareVersion %>#$SOFTWARE_VERSION#" \
| sed -e "s#<%= packageSoftwareVersion %>#$SOFTWARE_VERSION#" \
| sed -e 's#<%= destDir %>#/usr/local/openssh-init#' \
| sed -e 's#<%= destDir_openssl %>#/usr/local/openssl-init#' \
| sed -e 's#<%= externalDestDir_openssl %>#/usr/local/openssl-init#' \
| fgrep -v -- '--with-zlib' \
> install-openssh.sh &&

# Run install script
./install-openssh.sh &&

# Create symlinks
ln -sf openssh-init /usr/local/openssh &&
ln -sf openssh /usr/local/ssh &&

# Download and install configuration
mkdir -p /var/src/daemons &&
cd       /var/src/daemons &&
rm -f sshd_config &&
a2oBootstrap_download "$A2O_REPO_URI/modules/a2o_essential_linux_openssh/files/sshd_config" &&
mkdir -p /etc/ssh &&
cat sshd_config \
| sed -e 's/without-password/yes/' \
> /etc/ssh/sshd_config &&

# Download and install startup script
rm -f rc.sshd &&
a2oBootstrap_download "$A2O_REPO_URI/modules/a2o_essential_linux_openssh/templates/rc.sshd" &&
cp rc.sshd rc.sshd.dist &&
cat rc.sshd.dist \
| sed -e 's#<%= destDir_openssl %>#/usr/local/openssl-init#' \
| sed -e 's#<%= externalDestDir_openssl %>#/usr/local/openssl-init#' \
> rc.sshd &&
chmod 755 rc.sshd &&
mv rc.sshd /etc/rc.d/rc.sshd &&

# Download and install startup script helper
mkdir -p /etc/rc.tool &&
cd       /etc/rc.tool &&
rm -f common &&
a2oBootstrap_download "$A2O_REPO_URI/modules/a2o-essential-unix/files/rctool/common" &&
chmod 755 common &&



###
### Check final exit status
###
true
if [ "$?" != "0" ]; then
    echo "ERROR: Unable to install OpenSSH"
    exit 1
fi
echo
echo "########## (in chroot) OK: Installation of OpenSSH has been completed."
echo
