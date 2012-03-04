#!/bin/sh



### Create compile dirs
mkdir -p /var/src &&
mkdir -p /var/src/libs &&
mkdir -p /var/src/puppet-sys &&



### Download build_functions.sh
cd /var/src &&
rm -f build_functions.sh &&
wget --no-check-certificate https://raw.github.com/a2o/puppet-modules-a2o-essential/master/modules/a2o-essential-unix/files/compiletool/build_functions.sh &&
chmod 755 build_functions.sh &&

# Symlink
rm -f _functions.sh &&
ln -s build_functions.sh _functions.sh &&



### All done
exit 0
