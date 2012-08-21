#!/bin/bash
###########################################################################
# a2o Essential Puppet Modules                                            #
#-------------------------------------------------------------------------#
# Copyright (c) 2012 Bostjan Skufca                                       #
#-------------------------------------------------------------------------#
# This source file is subject to version 2.0 of the Apache License,       #
# that is bundled with this package in the file LICENSE, and is           #
# available through the world-wide-web at the following url:              #
# http://www.apache.org/licenses/LICENSE-2.0                              #
#-------------------------------------------------------------------------#
# Authors: Bostjan Skufca <my_name [at] a2o {dot} si>                     #
###########################################################################



# Compile directory
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions, releases and directories
export PDESTDIR_PHP="<%= destDir_php %>" &&
export PVERSION_ZF="<%=  softwareVersion_zf  %>" &&



### Install Zend framework
# CheckURI: http://framework.zend.com/
cd $PDESTDIR_PHP/lib/php &&
wget -c http://framework.zend.com/releases/ZendFramework-$PVERSION_ZF/ZendFramework-$PVERSION_ZF-minimal.tar.gz &&
rm -rf ZendFramework-$PVERSION_ZF-minimal &&
tar -xzf ZendFramework-$PVERSION_ZF-minimal.tar.gz &&
chown root.root -R ZendFramework-$PVERSION_ZF-minimal &&
rm -rf ./Zend &&
mv ZendFramework-$PVERSION_ZF-minimal/library/Zend . &&



### Install PEAR and modules
# CheckURI: http://pear.php.net/

# Update modules
$PDESTDIR_PHP/bin/pear upgrade --force &&



true
