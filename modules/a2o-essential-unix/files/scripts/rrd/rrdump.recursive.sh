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



### Parameters
if [ "x$1" == "x" ]; then
    echo "ERROR: First parameter must be a RRD source directory"
    exit 1
fi
RRD_SRC=$1
if [ "x$2" == "x" ]; then
    echo "ERROR: Second parameter must be a RRD XML dump destination directory"
    exit 2
fi
XML_DEST=$2



### Recursive dump
for DIRFILE in `cd $RRD_SRC && find . -name '*.rrd'`; do
    DIRNAME=`dirname $DIRFILE`

    echo "Dumping $RRD_SRC/$DIRFILE ---> $XML_DEST/$DIRFILE.xml "

    mkdir -p $XML_DEST/$DIRNAME
    rrdtool dump $RRD_SRC/$DIRFILE > $XML_DEST/$DIRFILE.xml
done
