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



### Init
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_ICU="<%= packageSoftwareVersion %>" &&



### ICU
# CheckURI: http://site.icu-project.org/download
# ReqBy: PHP pecl intl extension
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="icu" &&
export PVERSION="$PVERSION_ICU" &&
export PVERSION_USCORES=`echo $PVERSION | sed -e 's/\./_/g'` &&
export PDIR="icu" &&
export PFILE="icu4c-$PVERSION_USCORES-src.tgz" &&
export PURI="http://download.icu-project.org/files/icu4c/$PVERSION/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

cd source &&
./configure &&
make &&
make install &&
ldconfig &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
