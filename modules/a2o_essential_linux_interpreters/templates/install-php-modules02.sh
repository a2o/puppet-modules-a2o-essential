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
export PVERSION_APC="<%= softwareVersion_apc %>" &&



### APC
# CheckURI: http://pecl.php.net/package/APC
cd $SRCROOT && . ../_functions.sh &&
export PNAME="APC" &&
export PVERSION="$PVERSION_APC" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tgz" &&
export PURI="http://pecl.php.net/get/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

$PDESTDIR_PHP/bin/phpize &&
./configure --with-php-config=$PDESTDIR_PHP/bin/php-config &&
make -j 2 &&
make install &&

cd $SRCROOT &&
rm -rf $PDIR



if [ "$?" != "0" ]; then
    exit 1
fi



### First discover all channels - no exit status checking here
$PDESTDIR_PHP/bin/pear channel-discover components.ez.no
$PDESTDIR_PHP/bin/pear channel-discover pear.pdepend.org
$PDESTDIR_PHP/bin/pear channel-discover pear.phing.info
$PDESTDIR_PHP/bin/pear channel-discover pear.phpmd.org
$PDESTDIR_PHP/bin/pear channel-discover pear.phpunit.de
$PDESTDIR_PHP/bin/pear channel-discover pear.symfony-project.com

$PDESTDIR_PHP/bin/pear channel-update   components.ez.no
$PDESTDIR_PHP/bin/pear channel-update   pear.pdepend.org
$PDESTDIR_PHP/bin/pear channel-update   pear.phing.info
$PDESTDIR_PHP/bin/pear channel-update   pear.phpmd.org
$PDESTDIR_PHP/bin/pear channel-update   pear.phpunit.de
$PDESTDIR_PHP/bin/pear channel-update   pear.symfony-project.com



### Install modules
printf "\n" | $PDESTDIR_PHP/bin/pear install --force pecl/uuid &&
$PDESTDIR_PHP/bin/pear install --force pecl/gearman &&

### PHP code testing
$PDESTDIR_PHP/bin/pear install --force phpunit/PHPUnit &&
$PDESTDIR_PHP/bin/pear install --force phpunit/DbUnit &&
$PDESTDIR_PHP/bin/pear install --force phpunit/PHPUnit_MockObject &&
$PDESTDIR_PHP/bin/pear install --force phpunit/PHPUnit_Selenium &&
printf "\n\n\n" | $PDESTDIR_PHP/bin/pear upgrade --force --alldeps phing/phing &&

### Jenkins prerequisites
$PDESTDIR_PHP/bin/pear upgrade           pdepend/PHP_Depend &&
$PDESTDIR_PHP/bin/pear upgrade --alldeps phpmd/PHP_PMD &&
$PDESTDIR_PHP/bin/pear upgrade           phpunit/phploc &&
$PDESTDIR_PHP/bin/pear upgrade           phpunit/PHP_CodeBrowser &&
$PDESTDIR_PHP/bin/pear upgrade           PHP_CodeSniffer
# phpcpd already by phpunit? phing?

if [ "$?" != "0" ]; then
    exit 1
fi



true
