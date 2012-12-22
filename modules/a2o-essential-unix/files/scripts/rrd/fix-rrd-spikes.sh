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



### CLI arguments
if [ "$#" != "2" ]; then
    echo "ERROR: Two arguments required - rrd file and exponent number regex to cut ('\(0[7-9]\|1[0-9]\)' or similar)"
    exit 1
fi
RRDFILE=$1
CUTEXPREGEX=$2



### Files
RRDFILEBAK="$1.bak"
XMLFILE="$1.xml"
XMLFILEFIXED="$1.xml.fixed"
RRDFILEFIXED="$1.fixed"



### Check if backup file already exists
if [ -e $RRDFILEBAK ]; then
    echo "ERROR: Backup RRD file already exists: $RRDFILEBAK"
    exit 1
fi
if [ -e $RRDFILEFIXED ]; then
    echo "ERROR: Fixed RRD file already exists: $RRDFILEFIXED"
    exit 1
fi



### Copy and dump
cp $RRDFILE $RRDFILEBAK &&
rrdtool dump $RRDFILE > $XMLFILE &&



### Fix spikes
cat $XMLFILE | sed -e "s#[0-9]\.[0-9]\+e[+]$CUTEXPREGEX#NaN#g" > $XMLFILEFIXED &&



### Create new rrd file
rrdtool restore $XMLFILEFIXED $RRDFILEFIXED
