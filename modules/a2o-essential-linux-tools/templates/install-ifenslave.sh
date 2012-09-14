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



### Ifenslave
# CheckURI: http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=blob_plain;f=Documentation/networking/ifenslave.c;hb=HEAD
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="ifenslave" &&
export PFILE="$PNAME.c" &&
export PURI="http://source.a2o.si/source-packages/$PFILE" &&

rm -rf $PDIR &&
GetArchive &&

gcc -o ifenslave ifenslave.c &&
mv ifenslave /sbin/ &&



true
