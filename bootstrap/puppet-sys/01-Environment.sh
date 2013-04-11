#!/bin/sh



### Create compile dirs
mkdir -p /var/src &&
mkdir -p /var/src/libs &&
mkdir -p /var/src/puppet-sys &&


### Determine source URI
if [ "$A2O_REPO_URI" != "" ]; then
    URI_PREFIX="$A2O_REPO_URI"
else
    URI_PREFIX="http://source.a2o.si/git/puppet-modules-a2o-essential/raw/master"
fi &&


### Download build_functions.sh
cd /var/src &&
rm -f act_functions.sh &&
wget --no-check-certificate "$URI_PREFIX/modules/a2o-essential-unix/files/act/act_functions.sh" &&
chmod 755 act_functions.sh &&


# Symlink
rm -f _functions.sh &&
rm -f build_functions.sh &&
ln -s act_functions.sh _functions.sh &&
ln -s act_functions.sh build_functions.sh &&



true
