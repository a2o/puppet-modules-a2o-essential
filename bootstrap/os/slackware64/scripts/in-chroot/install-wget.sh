#!/bin/bash



###
### Bootstrap environment check
###
if [ "$A2O_REPO_URI" == "" ]; then
    echo "Hint:  export A2O_REPO_URI='http://source.a2o.si/git/puppet-modules-a2o-essential/raw/master'"
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
### Get wget install script and version
###
# Version: FIXME, get from manifests/wget.pp file
export SOFTWARE_VERSION="1.14" &&
export INSTALL_SCRIPT="install-wget.sh" &&
mkdir -p /var/src/tools &&
cd       /var/src/tools &&
a2oBootstrap_download "$A2O_REPO_URI/modules/a2o-essential-linux-tools/templates/$INSTALL_SCRIPT" &&

### Populate variables
cp $INSTALL_SCRIPT $INSTALL_SCRIPT.dist &&
cat $INSTALL_SCRIPT.dist \
| sed -e 's#<%= compileDir %>#/var/src/tools#' \
| sed -e "s#<%= softwareVersion %>#$SOFTWARE_VERSION#" \
| sed -e "s#<%= packageSoftwareVersion %>#$SOFTWARE_VERSION#" \
| sed -e 's#<%= destDir_openssl %>#/usr/local/openssl-init#' \
| sed -e 's#<%= externalDestDir_openssl %>#/usr/local/openssl-init#' \
> $INSTALL_SCRIPT &&
./$INSTALL_SCRIPT &&

### Create symlink for just in case
if [ ! -f /usr/bin/wget ]; then
    ln -s /usr/local/bin/wget /usr/bin/wget
fi



###
### Check final exit status
###
if [ "$?" != "0" ]; then
    echo "ERROR: Unable to install wget"
    exit 1
fi
echo
echo "########## (in chroot) OK: Installation of wget has been completed."
echo
