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



### Set versions and directories
export PVERSION_TIG="<%= packageSoftwareVersion %>" &&



### Vmtouch
# CheckURI: http://hoytech.com/vmtouch/
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="vmtouch" &&
export PFILE="$PNAME.c" &&
export PURI="https://raw.github.com/hoytech/vmtouch/master/$PFILE" &&

GetArchive &&

gcc -Wall -O3 -o vmtouch vmtouch.c &&
mv vmtouch /usr/local/bin &&



exit 0
