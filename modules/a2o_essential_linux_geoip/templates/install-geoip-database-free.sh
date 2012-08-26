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
export PVERSION_SW="<%= softwareVersion %>" &&
export PDESTDIR="<%= destDir %>" &&



### Install MaxMind GeoIP free databases
mkdir -p $PDESTDIR/install-tmp &&
cd $PDESTDIR/install-tmp &&
rm -f *.dat &&
rm -f *.gz  &&

#wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz &&
#wget http://geolite.maxmind.com/download/geoip/database/GeoIPv6.dat.gz &&
#wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz &&
#wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCityv6-beta/GeoLiteCityv6.dat.gz &&
wget http://source.a2o.si/files/geoip/$PVERSION_SW/GeoIP.dat.gz &&
wget http://source.a2o.si/files/geoip/$PVERSION_SW/GeoIPv6.dat.gz &&
wget http://source.a2o.si/files/geoip/$PVERSION_SW/GeoLiteCity.dat.gz &&
wget http://source.a2o.si/files/geoip/$PVERSION_SW/GeoLiteCityv6.dat.gz &&

gunzip           Geo*.dat.gz &&
chown  root.root Geo*.dat    &&
chmod  644       Geo*.dat    &&

mv -f Geo*.dat $PDESTDIR &&

# Cleanup
cd $PDESTDIR &&
rmdir install-tmp &&



true
