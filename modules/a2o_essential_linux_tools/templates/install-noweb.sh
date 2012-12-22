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



### Init
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_SW="<%= softwareVersion %>" &&



### NoWeb
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="noweb" &&
export PVERSION="$PVERSION_SW" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tgz" &&
export PURI="ftp://www.eecs.harvard.edu/pub/nr/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

cd src &&

mv Makefile Makefile.orig &&
cat Makefile.orig \
| sed -e 's#^BIN=/usr/local/noweb$#BIN=/usr/local/bin#' \
| sed -e 's#^LIB=/usr/local/noweb/lib$#LIB=/usr/local/lib#' \
| sed -e 's#^MAN=/usr/local/noweb/man$#MAN=/usr/local/man#' \
> Makefile &&

make &&
make install-code &&
make install-man &&

cd .. &&

cd $SRCROOT &&
rm -rf $PDIR &&



true
