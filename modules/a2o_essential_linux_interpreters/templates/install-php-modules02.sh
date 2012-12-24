#!/bin/bash
###########################################################################
# a2o Essential Puppet Modules                                            #
#-------------------------------------------------------------------------#
# Copyright (c) Bostjan Skufca                                            #
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
. /var/src/build_functions.sh &&



### Set versions, releases and directories
export PDESTDIR_PHP="<%= destDir_php %>" &&
export PVERSION_APC="<%= softwareVersion_apc %>" &&



### Pecl extensions
php_installPackage_pecl $PDESTDIR_PHP APC       APC-$PVERSION_APC        &&
php_installPackage_pecl $PDESTDIR_PHP gearman   &&
php_installPackage_pecl $PDESTDIR_PHP memcache  &&
php_installPackage_pecl $PDESTDIR_PHP memcached &&
php_installPackage_pecl $PDESTDIR_PHP mongo     &&
php_installPackage_pecl $PDESTDIR_PHP uuid      &&
php_installPackage_pecl $PDESTDIR_PHP xdebug    &&
php_installPackage_pecl $PDESTDIR_PHP yaf       &&
php_installPackage_pecl $PDESTDIR_PHP yaml      &&
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig &&
php_installPackage_pecl $PDESTDIR_PHP imagick   imagick-beta             &&
unset PKG_CONFIG_PATH &&



### Pear - channel discovery
php_discoverChannel_pear   $PDESTDIR_PHP   components.ez.no           &&
php_discoverChannel_pear   $PDESTDIR_PHP   pear.pdepend.org           &&
php_discoverChannel_pear   $PDESTDIR_PHP   pear.phing.info            &&
php_discoverChannel_pear   $PDESTDIR_PHP   pear.phpmd.org             &&
php_discoverChannel_pear   $PDESTDIR_PHP   pear.phpunit.de            &&
php_discoverChannel_pear   $PDESTDIR_PHP   pear.symfony-project.com   &&
php_discoverChannel_pear   $PDESTDIR_PHP   pear.symfony.com           &&



### Pear - module installation
php_installPackage_pear   $PDESTDIR_PHP   PHPUnit              phpunit/PHPUnit              &&
php_installPackage_pear   $PDESTDIR_PHP   DbUnit               phpunit/DbUnit               &&
php_installPackage_pear   $PDESTDIR_PHP   PHPUnit_MockObject   phpunit/PHPUnit_MockObject   &&
php_installPackage_pear   $PDESTDIR_PHP   PHPUnit_Selenium     phpunit/PHPUnit_Selenium     &&
php_installPackage_pear   $PDESTDIR_PHP   phing                phing/phing                  &&
php_installPackage_pear   $PDESTDIR_PHP   Yaml                 pear.symfony.com/Yaml        &&



### Jenkins prerequisites
php_installPackage_pear   $PDESTDIR_PHP   PHP_Depend        pdepend/PHP_Depend &&
php_installPackage_pear   $PDESTDIR_PHP   PHP_PMD           phpmd/PHP_PMD &&   # --alldeps?
php_installPackage_pear   $PDESTDIR_PHP   phploc            phpunit/phploc &&
php_installPackage_pear   $PDESTDIR_PHP   PHP_CodeBrowser   phpunit/PHP_CodeBrowser &&
php_installPackage_pear   $PDESTDIR_PHP   PHP_CodeSniffer   &&
# phpcpd already by phpunit? phing?



true
