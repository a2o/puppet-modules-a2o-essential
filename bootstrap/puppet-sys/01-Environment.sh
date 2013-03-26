#!/bin/sh



### Create compile dirs
mkdir -p /var/src &&
mkdir -p /var/src/libs &&
mkdir -p /var/src/puppet-sys &&


### Determine source URI
if [ "$A2O_REPO_URI" != "" ]; then
    URI_PREFIX="$A2O_REPO_URI"
else
    URI_PREFIX="https://raw.github.com/a2o/puppet-modules-a2o-essential/master"
fi &&


### Download build_functions.sh
cd /var/src &&
rm -f build_functions.sh &&
wget --no-check-certificate "$URI_PREFIX/modules/a2o-essential-unix/files/compiletool/build_functions.sh" &&
chmod 755 build_functions.sh &&


# Symlink
rm -f _functions.sh &&
ln -s build_functions.sh _functions.sh
