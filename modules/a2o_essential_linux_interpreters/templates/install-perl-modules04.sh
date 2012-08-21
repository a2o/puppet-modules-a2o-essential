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
export SRCROOT="<%= compileDir %>/perl_modules" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions, releases and directories
export PDESTDIR_PERL="<%=    destDir_perl            %>" &&
export PDESTDIR_OPENSSL="<%= externalDestDir_openssl %>" &&



### Install modules
# CheckURI: http://www.cpan.org/modules/01modules.index.html



# These modules are for: pflogsumm (log summary for postfix)



cd $SRCROOT && . ../../_functions.sh &&
export PNAME="Sub-Uplevel" &&
export PVERSION="0.22" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cpan.org/authors/id/D/DA/DAGOLDEN/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
$PDESTDIR_PERL/bin/perl Makefile.PL &&
make &&
make install &&
cd $SRCROOT && rm -rf $PDIR &&



cd $SRCROOT && . ../../_functions.sh &&
export PNAME="Test-Exception" &&
export PVERSION="0.31" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cpan.org/authors/id/A/AD/ADIE/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
$PDESTDIR_PERL/bin/perl Makefile.PL &&
make &&
make install &&
cd $SRCROOT && rm -rf $PDIR &&



cd $SRCROOT && . ../../_functions.sh &&
export PNAME="Carp-Clan" &&
export PVERSION="6.04" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cpan.org/authors/id/S/ST/STBEY/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
$PDESTDIR_PERL/bin/perl Makefile.PL &&
make &&
make install &&
cd $SRCROOT && rm -rf $PDIR &&



cd $SRCROOT && . ../../_functions.sh &&
export PNAME="Bit-Vector" &&
export PVERSION="7.1" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cpan.org/authors/id/S/ST/STBEY/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
$PDESTDIR_PERL/bin/perl Makefile.PL &&
make &&
make install &&
cd $SRCROOT && rm -rf $PDIR &&



cd $SRCROOT && . ../../_functions.sh &&
export PNAME="Date-Calc" &&
export PVERSION="6.3" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cpan.org/authors/id/S/ST/STBEY/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
$PDESTDIR_PERL/bin/perl Makefile.PL &&
make &&
make install UNINST=1 &&
cd $SRCROOT && rm -rf $PDIR &&



cd $SRCROOT && . ../../_functions.sh &&
export PNAME="UUID-Tiny" &&
export PVERSION="1.03" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cpan.org/authors/id/C/CA/CAUGUSTIN/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
$PDESTDIR_PERL/bin/perl Makefile.PL &&
make &&
make install &&
cd $SRCROOT && rm -rf $PDIR &&



rm -rf /root/.cpan
