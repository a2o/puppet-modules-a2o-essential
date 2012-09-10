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



### Parameters
if [ "x$1" == "x" ]; then
    echo "ERROR: First parameter must be a RRD XML dump source directory"
    exit 1
fi
XML_SRC=$1
if [ "x$2" == "x" ]; then
    echo "ERROR: Second parameter must be a RRD destination directory"
    exit 2
fi
RRD_DEST=$2



### Recursive dump
for DIRFILE in `cd $XML_SRC && find . -name '*.rrd.xml'`; do
    DIRNAME=`dirname $DIRFILE`
    DESTDIRFILE=`echo "$DIRFILE" | sed -e 's/\.xml$//'`

    echo "Restoring $XML_SRC/$DIRFILE ---> $RRD_DEST/$DESTDIRFILE "

    mkdir -p $RRD_DEST/$DIRNAME
    rrdtool restore $XML_SRC/$DIRFILE $RRD_DEST/$DESTDIRFILE
done
