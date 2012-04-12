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



### Set versions and directories
export PVERSION_SW="<%= packageSoftwareVersion %>" &&



### PsTree
# CheckURI: http://www.thp.uni-duisburg.de/pstree/
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="pstree" &&
# WARNING: Keep version info empty!
export PVERSION="" &&
export PDIR="$PNAME" &&
export PFILE="$PNAME.tar.gz" &&
export PURI="http://www.thp.uni-duisburg.de/pstree/$PFILE" &&

rm -rf $PDIR &&
GetUnpack &&

mkdir pstree &&
mv README pstree.c pstree/ &&
cd pstree &&
cc -O -o pstree pstree.c &&
/bin/install -m 755 pstree /bin/pstre &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
