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



### Zend Framework
# CheckURI: http://framework.zend.com/
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="ZendFramework" &&
export PVERSION="$PVERSION_ZF" &&
export PDIR="$PNAME-$PVERSION-minimal" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://framework.zend.com/releases/ZendFramework-$PVERSION_ZF/$PFILE" &&

rm -rf $PDIR &&
GetUnpack &&

chown root.root $PDIR &&
rm -rf $PDESTDIR_PHP/lib/php/Zend &&
mv $PDIR/library/Zend $PDESTDIR_PHP/lib/php &&

cd $SRCROOT &&
rm -rf $PDIR &&



### Install PEAR and modules
# CheckURI: http://pear.php.net/

# Update modules
$PDESTDIR_PHP/bin/pear upgrade --force &&



true
