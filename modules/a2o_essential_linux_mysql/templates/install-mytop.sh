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



### Compile directory
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_SW="<%= softwareVersion %>" &&



### MyTOP
# CheckURI: http://jeremy.zawodny.com/mysql/mytop/
cd $SRCROOT && . ../_functions.sh &&
export PNAME="mytop" &&
export PVERSION="$PVERSION_SW" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://jeremy.zawodny.com/mysql/mytop/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

perl Makefile.PL &&
make &&

# Fix error because of Perl::GetOpt::Long and
# Fix MySQL global status display
# Change default db to ''
cat mytop \
| sed -e 's/ "long|!"/#"long|!"/g' \
| sed -e "s/ 'test'/ ''/g" \
| sed -e 's/show status/show global status/ig' \
| sed -e 's/show variables/show global variables/ig' \
> mytop.new && 
mv mytop mytop.gen &&
mv mytop.new mytop &&
chmod 755 mytop &&

# Install it - This sucks!
#make install &&
rm -f /usr/local/perl/bin/mytop &&
rm -f /usr/local/bin/mytop &&
cp ./mytop /usr/local/perl/bin &&
cp ./mytop /usr/local/bin &&

cd $SRCROOT &&
rm -rf $PDIR &&



true
