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

# Step 1: Source the functions again
mkdir -p $WORK_DIR &&
cd $WORK_DIR &&
rm -f _os_install_functions.sh &&
wget "$A2O_BOOTSTRAP_URI/scripts/_os_install_functions.sh" &&
. ./_os_install_functions.sh

# Step 1: Misc thingies first
a2oScript_downloadAndRun $A2O_BOOTSTRAP_URI/scripts/in-chroot/ldconfig.sh   &&

# Step 2: Compilation environment
a2oScript_downloadAndRun $A2O_BOOTSTRAP_URI/scripts/in-chroot/setup-compilation-env.sh   &&

# Step 3: Zlib
a2oScript_downloadAndRun $A2O_BOOTSTRAP_URI/scripts/in-chroot/install-zlib.sh   &&

#cd /var/src/libs &&
#rm install-zlib.sh &&
#wget --no-check-certificate $A2O_BOOTSTRAP_URI/modules/a2o_essential_linux_libs/templates/install-zlib.sh &&


# Step 4: Bootstrap up to runable puppet-sys


# Step 4: Final thingies
# - root password
# - puppet-sys/puppet.conf configuration



true
