#!/bin/bash


### Configuration
export URI_PREFIX="https://raw.github.com/a2o/puppet-modules-a2o-essential/master/bootstrap/puppet-sys" &&
export FILES="01-Environment.sh 02-OpenSSL.sh 03-Puppet-sys-01-Ruby.sh 03-Puppet-sys-02-Facter.sh 03-Puppet-sys-03-Puppet.sh 03-Puppet-sys-04-Files.sh 03-Puppet-sys-05-Config.sh" &&
export LOCAL_BOOTSTRAP_DIR="/var/src/bootstrap" &&


### Make directory
mkdir -p $LOCAL_BOOTSTRAP_DIR &&


### Preventive cleanup
cd $LOCAL_BOOTSTRAP_DIR &&
rm -f ./*.sh &&


### Download first
for FILE in $FILES; do
    wget --no-check-certificate $URI_PREFIX/$FILE
    RES=$?
    if [ "$RES" != "0" ]; then
	echo "ERROR: Failure downloading file $FILE"
	exit 1
    fi
done


### Then execute
for FILE in $FILES; do
    cd $LOCAL_BOOTSTRAP_DIR &&
    chmod 755 ./$FILE &&
    ./$FILE
    RES=$?
    if [ "$RES" != "0" ]; then
	echo "ERROR: Failure while executing file $FILE"
	exit 1
    fi
done
