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
### Get and install environment
###
a2oScript_downloadAndRun "$A2O_REPO_URI/bootstrap/puppet-sys/01-Environment.sh"
if [ "$?" != "0" ]; then
    echo "ERROR: Unable to set up compilation environment"
    exit 1
fi



echo
echo "########## (in chroot) OK: Compilation environment has been set up."
echo
