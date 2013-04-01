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
### Install PERL
###
# Version: FIXME, get from .pp file
export SOFTWARE_VERSION="5.16.3" &&
mkdir -p /var/src/interpreters &&
cd       /var/src/interpreters &&
a2oBootstrap_download "$A2O_REPO_URI/modules/a2o_essential_linux_interpreters/templates/install-perl.sh" &&
cp install-perl.sh install-perl.sh.dist &&
cat install-perl.sh.dist \
| sed -e 's#<%= compileDir %>#/var/src/interpreters#' \
| sed -e 's#<%=\s\+destDir\s\+%>#/usr/local/perl-init#' \
| sed -e "s#<%=\s\+softwareVersion\s\+%>#$SOFTWARE_VERSION#" \
> install-perl.sh &&
./install-perl.sh &&

# Symlinks
ln -sf perl-init /usr/local/perl &&
ln -sf /usr/local/perl/bin/perl /usr/local/bin/perl &&
ln -sf /usr/local/perl/bin/pod2man /usr/local/bin/pod2man &&
ln -sf /usr/local/bin/perl /usr/bin/perl



###
### Check final exit status
###
if [ "$?" != "0" ]; then
    echo "ERROR: Unable to install PERL"
    exit 1
fi
echo
echo "########## (in chroot) OK: Installation of PERL has been completed."
echo
