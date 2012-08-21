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



# General modules again



cd $SRCROOT && . ../../_functions.sh &&
export PNAME="HTTP-Date" &&
export PVERSION="6.00" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cpan.org/authors/id/G/GA/GAAS/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
$PDESTDIR_PERL/bin/perl Makefile.PL &&
make &&
make install &&
cd $SRCROOT && rm -rf $PDIR &&



cd $SRCROOT && . ../../_functions.sh &&
export PNAME="Encode-Locale" &&
export PVERSION="1.02" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cpan.org/authors/id/G/GA/GAAS/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
$PDESTDIR_PERL/bin/perl Makefile.PL &&
make &&
make install &&
cd $SRCROOT && rm -rf $PDIR &&



cd $SRCROOT && . ../../_functions.sh &&
export PNAME="HTML-Tagset" &&
export PVERSION="3.20" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cpan.org/authors/id/P/PE/PETDANCE/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
$PDESTDIR_PERL/bin/perl Makefile.PL &&
make &&
make install &&
cd $SRCROOT && rm -rf $PDIR &&



cd $SRCROOT && . ../../_functions.sh &&
export PNAME="HTML-Parser" &&
export PVERSION="3.69" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cpan.org/authors/id/G/GA/GAAS/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
$PDESTDIR_PERL/bin/perl Makefile.PL &&
make &&
make install &&
cd $SRCROOT && rm -rf $PDIR &&



cd $SRCROOT && . ../../_functions.sh &&
export PNAME="URI" &&
export PVERSION="1.59" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cpan.org/authors/id/G/GA/GAAS/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
$PDESTDIR_PERL/bin/perl Makefile.PL &&
make &&
make install &&
cd $SRCROOT && rm -rf $PDIR &&



cd $SRCROOT && . ../../_functions.sh &&
export PNAME="LWP-MediaTypes" &&
export PVERSION="6.01" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cpan.org/authors/id/G/GA/GAAS/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
$PDESTDIR_PERL/bin/perl Makefile.PL &&
make &&
make install &&
cd $SRCROOT && rm -rf $PDIR &&



cd $SRCROOT && . ../../_functions.sh &&
export PNAME="HTTP-Message" &&
export PVERSION="6.02" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cpan.org/authors/id/G/GA/GAAS/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
$PDESTDIR_PERL/bin/perl Makefile.PL &&
make &&
make install &&
cd $SRCROOT && rm -rf $PDIR &&



cd $SRCROOT && . ../../_functions.sh &&
export PNAME="ExtUtils-Install" &&
export PVERSION="1.54" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cpan.org/authors/id/Y/YV/YVES/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
$PDESTDIR_PERL/bin/perl Makefile.PL &&
make &&
make install &&
cd $SRCROOT && rm -rf $PDIR &&



rm -rf /root/.cpan
