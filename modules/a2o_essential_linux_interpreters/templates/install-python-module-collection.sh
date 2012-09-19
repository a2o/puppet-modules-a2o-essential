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
export PDESTDIR_PYTHON="<%= destDir_python %>" &&
export PVERSION_SETUPT="<%= softwareVersion_setuptools %>" &&
export PVERSION_DJANGO="<%= softwareVersion_django %>" &&



### Set python path - SuSE
export PATH="$PDESTDIR_PYTHON/bin:$PATH" &&



### SetupTools
# CheckURI: http://pypi.python.org/pypi/setuptools#files
cd $SRCROOT && . /var/src/build_functions.sh &&
export PNAME="setuptools" &&
export PVERSION="$PVERSION_SETUPT" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://pypi.python.org/packages/source/s/setuptools/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

$PDESTDIR_PYTHON/bin/python setup.py install &&

cd $SRCROOT &&
rm -rf $PDIR &&



### Django
# CheckURI: https://www.djangoproject.com/download/
cd $SRCROOT && . /var/src/build_functions.sh &&
export PNAME="Django" &&
export PVERSION="$PVERSION_DJANGO" &&
export PVERSION_MAJOR=`echo "$PVERSION" | cut -d'.' -f1,2 `&&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.djangoproject.com/m/releases/$PVERSION_MAJOR/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

$PDESTDIR_PYTHON/bin/python setup.py install &&

cd $SRCROOT &&
rm -rf $PDIR &&



### Install other modules
# Pootle
$PDESTDIR_PYTHON/bin/easy_install translate-toolkit &&
$PDESTDIR_PYTHON/bin/easy_install lxml              &&
$PDESTDIR_PYTHON/bin/easy_install south             &&



true
