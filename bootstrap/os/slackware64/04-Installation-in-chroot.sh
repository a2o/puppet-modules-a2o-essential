###
### In-chroot installation steps
###

#
# WARNING
# WARNING: Before using this file, you have to run 02-Environment-setup.txt
# WARNING: (environment from pre-chroot is preserved)
# WARNING
#

# This file indicates steps to be taken once inside chroot to new OS root disk.



###
### IN-CHROOT installation procedure
###
### This is an automated procedure.
### If you want to do something manually, check the scripts what is to be done and how.
###

# Source the functions again
mkdir -p $WORK_DIR &&
cd $WORK_DIR &&
rm -f _os_install_functions.sh &&
wget "$A2O_BOOTSTRAP_URI/scripts/_os_install_functions.sh" &&
. ./_os_install_functions.sh

# Compilation environment
a2oScript_downloadAndRun $A2O_BOOTSTRAP_URI/scripts/in-chroot/ldconfig.sh                &&
a2oScript_downloadAndRun $A2O_BOOTSTRAP_URI/scripts/in-chroot/setup-compilation-env.sh   &&

# Install and remove stuff
a2oScript_downloadAndRun $A2O_BOOTSTRAP_URI/scripts/in-chroot/install-zlib.sh            &&
a2oScript_downloadAndRun $A2O_BOOTSTRAP_URI/scripts/in-chroot/install-perl.sh            &&
a2oScript_downloadAndRun $A2O_BOOTSTRAP_URI/scripts/in-chroot/install-openssl.sh         &&
a2oScript_downloadAndRun $A2O_BOOTSTRAP_URI/scripts/in-chroot/install-wget.sh            &&
a2oScript_downloadAndRun $A2O_BOOTSTRAP_URI/scripts/in-chroot/remove-openssl-solibs.sh   &&
a2oScript_downloadAndRun $A2O_BOOTSTRAP_URI/scripts/in-chroot/install-openssh.sh         &&

# Finally bootstrap puppet-sys
a2oScript_downloadAndRun $A2O_REPO_URI/bootstrap/puppet-sys/XX-All.sh   &&

# Final misc tasks
a2oScript_downloadAndRun $A2O_BOOTSTRAP_URI/scripts/in-chroot/change-root-password.sh   &&


# Notify the user
echo "In-chroot installation complete.

Next steps:
- configure the /etc/puppet-sys/puppet.conf
- reboot
- after machine comes back up, run 'puppet-sys agent --test'
" &&


true
