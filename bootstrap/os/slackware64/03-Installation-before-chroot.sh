###
### Before-chroot installation steps
###

#
# WARNING
# WARNING: Before using this file, you have to run 02-Environment-setup.txt
# WARNING
#

# This is really boring part, and Slackware setup program is nice enough for
# doing it once, but repeating installations gets really mundane.
#
# Therefore we've created this script that installs list of preselected
# packages automagically.
#
# WARNING: The script expects the following mounts to be present:
# - /mnt/newroot   as new installation disk
# - /mnt/slack     as source media

#
# WARNING
# WARNING: Before using this file, you have to run 02-Environment-setup.txt
# WARNING
#


###
### BEFORE-CHROOT Installation procedure
###
### This is an automated procedure.
### If you want to do something manually, check the scripts what is to be done and how.
###


### Step 1: Main installation

# 1a - HW dependent (might be done manually)
a2oScript_downloadAndRun $A2O_BOOTSTRAP_URI/scripts/autopartition.sh     &&
a2oScript_downloadAndRun $A2O_BOOTSTRAP_URI/scripts/automount.sh         &&

# 1b - Common
a2oScript_downloadAndRun $A2O_BOOTSTRAP_URI/scripts/autoinstall.sh       &&
a2oScript_downloadAndRun $A2O_BOOTSTRAP_URI/scripts/cleanup.sh           &&


### Step 2: fstab, lilo.conf, mount-bind /dev, /proc, /sys, write MBR
a2oScript_downloadAndRun $A2O_BOOTSTRAP_URI/scripts/generate-fstab.sh       &&
a2oScript_downloadAndRun $A2O_BOOTSTRAP_URI/scripts/automount.sh            &&
$WORK_DIR/automount.sh binds-also                                           &&
a2oScript_downloadAndRun $A2O_BOOTSTRAP_URI/scripts/generate-lilo.conf.sh   &&


### Step 3: Various configs
a2oScript_downloadAndRun $A2O_BOOTSTRAP_URI/scripts/generate-timeconfig.sh   &&
a2oScript_downloadAndRun $A2O_BOOTSTRAP_URI/scripts/generate-netconfig.sh    &&
a2oScript_downloadAndRun $A2O_BOOTSTRAP_URI/scripts/generate-passwd.sh       &&
a2oScript_downloadAndRun $A2O_BOOTSTRAP_URI/scripts/generate-crontab.sh      &&


### Step 4: Various fixups
a2oScript_downloadAndRun $A2O_BOOTSTRAP_URI/scripts/fix-home.sh              &&



### Step 5: Prepare chroot script to run and go in there
a2oScript_download $A2O_BOOTSTRAP_URI/04-Installation-in-chroot.sh &&
mkdir -p ${DEST_ROOT}${WORK_DIR} &&
mv ./04-Installation-in-chroot.sh ${DEST_ROOT}${WORK_DIR} &&
chroot ${DEST_ROOT} ${WORK_DIR}/04-Installation-in-chroot.sh



### Bootstrap complete (watch for root password etc).
