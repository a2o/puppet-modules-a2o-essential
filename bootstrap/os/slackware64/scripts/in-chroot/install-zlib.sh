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
### Get zlib install script and version
###
# Version: FIXME, get from zlib/instance.pp file
export SOFTWARE_VERSION="1.2.7" &&
mkdir -p /var/src/libs &&
cd       /var/src/libs &&
a2oBootstrap_download "$A2O_REPO_URI/modules/a2o_essential_linux_libs/templates/install-zlib.sh" &&
cp install-zlib.sh install-zlib.sh.dist &&
cat install-zlib.sh.dist \
| sed -e 's#<%= compileDir %>#/var/src/libs#' \
| sed -e 's#<%= destDir %>#/usr/local#' \
| sed -e "s#<%= softwareVersion %>#$SOFTWARE_VERSION#" \
> install-zlib.sh &&
./install-zlib.sh



###
### Check final exit status
###
if [ "$?" != "0" ]; then
    echo "ERROR: Unable to install zlib"
    exit 1
fi
echo
echo "########## (in chroot) OK: Installation of zlib has been completed."
echo
