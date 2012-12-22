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

CDIR=/var/collectd/`hostname -f`

cd $CDIR &&
mkdir -p mysql-localhost-new &&
rm -f mysql-localhost-new/* &&

for RRDFILE in `ls mysql-localhost`; do
    OLDRRD="mysql-localhost/$RRDFILE" &&
    NEWRRDUMP="mysql-localhost-new/$RRDFILE.xml" &&
    NEWRRDUMPF="mysql-localhost-new/$RRDFILE.xml.fixed" &&
    NEWRRD="mysql-localhost-new/$RRDFILE" &&

    echo "$RRDFILE"

    rrdtool dump $OLDRRD $NEWRRDUMP &&

    if [[ "$RRDFILE" =~ "^mysql_handler" ]]; then
        cat $NEWRRDUMP | sed -e 's/<v>[^e]\+e[+]\(0[5-9]\|[1-9][0-9]\)</<v>NaN</g' > $NEWRRDUMPF
    elif [[ "$RRDFILE" =~ "^mysql_octets" ]]; then
        cat $NEWRRDUMP | sed -e 's/<v>[^e]\+e[+]\(0[6-9]\|[1-9][0-9]\)</<v>NaN</g' > $NEWRRDUMPF
    elif [[ "$RRDFILE" =~ "^mysql_qcache" ]]; then
        cat $NEWRRDUMP | sed -e 's/<v>[^e]\+e[+]\(0[3-9]\|[1-9][0-9]\)</<v>NaN</g' > $NEWRRDUMPF
    else
        cat $NEWRRDUMP | sed -e 's/<v>[^e]\+e[+]\(0[5-9]\|[1-9][0-9]\)</<v>NaN</g' > $NEWRRDUMPF
    fi &&

    rrdtool restore $NEWRRDUMPF $NEWRRD &&

    for DSINFO in `rrdtool info $NEWRRD | fgrep '.type =' | sed -e 's/ //g'`; do
	DSNAME=`echo $DSINFO | cut -d'[' -f2 | cut -d']' -f1`
	DSTYPE=`echo $DSINFO | cut -d'"' -f2`
	if [ "$DSTYPE" == "COUNTER" ]; then
	    rrdtool tune $NEWRRD --data-source-type $DSNAME:DERIVE
	    echo "  $DSNAME COUNTER->DERIVE"
	fi
    done

    rm $NEWRRDUMP $NEWRRDUMPF
done
