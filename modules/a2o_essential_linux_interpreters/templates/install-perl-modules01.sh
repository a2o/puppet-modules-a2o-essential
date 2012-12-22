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
export SRCROOT="<%= compileDir %>/perl_modules" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions, releases and directories
export PDESTDIR_PERL="<%=    destDir_perl            %>" &&
export PDESTDIR_OPENSSL="<%= externalDestDir_openssl %>" &&
export PDESTDIR_MYSQL="<%=   externalDestDir_mysql   %>" &&



### Install modules
# CheckURI: http://www.cpan.org/modules/01modules.index.html



### CPAN
cd $SRCROOT && . ../../_functions.sh &&
export PNAME="CPAN" &&
export PVERSION="1.9800" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cpan.org/authors/id/A/AN/ANDK/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
$PDESTDIR_PERL/bin/perl Makefile.PL &&
make &&
make install &&
cd $SRCROOT && rm -rf $PDIR &&



### YAML
cd $SRCROOT && . ../../_functions.sh &&
export PNAME="YAML" &&
export PVERSION="0.73" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cpan.org/authors/id/I/IN/INGY/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
$PDESTDIR_PERL/bin/perl Makefile.PL &&
make &&
make install &&
cd $SRCROOT && rm -rf $PDIR &&



### DBI
cd $SRCROOT && . ../../_functions.sh &&
export PNAME="DBI" &&
export PVERSION="1.616" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cpan.org/authors/id/T/TI/TIMB/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
$PDESTDIR_PERL/bin/perl Makefile.PL &&
make &&
make install &&
cd $SRCROOT && rm -rf $PDIR &&



### Term::Readkey
cd $SRCROOT && . ../../_functions.sh &&
export PNAME="TermReadKey" &&
export PVERSION="2.30" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cpan.org/authors/id/J/JS/JSTOWE/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
$PDESTDIR_PERL/bin/perl Makefile.PL &&
make &&
make install &&
cd $SRCROOT && rm -rf $PDIR &&



### ANSIColor
cd $SRCROOT && . ../../_functions.sh &&
export PNAME="ANSIColor" &&
export PVERSION="3.00" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cpan.org/authors/id/R/RR/RRA/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
$PDESTDIR_PERL/bin/perl Makefile.PL &&
make &&
make install &&
cd $SRCROOT && rm -rf $PDIR &&



### Term::ANSIColor
cd $SRCROOT && . ../../_functions.sh &&
export PNAME="Term-ANSIColor" &&
export PVERSION="3.01" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cpan.org/authors/id/R/RR/RRA/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
$PDESTDIR_PERL/bin/perl Makefile.PL &&
make &&
make install &&
cd $SRCROOT && rm -rf $PDIR &&



### Time::HiRes
cd $SRCROOT && . ../../_functions.sh &&
export PNAME="Time-HiRes" &&
export PVERSION="1.9724" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cpan.org/authors/id/Z/ZE/ZEFRAM/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
$PDESTDIR_PERL/bin/perl Makefile.PL &&
make &&
make install &&
cd $SRCROOT && rm -rf $PDIR &&



### XML::Parser
cd $SRCROOT && . ../../_functions.sh &&
export PNAME="XML-Parser" &&
export PVERSION="2.36" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cpan.org/authors/id/M/MS/MSERGEANT/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
$PDESTDIR_PERL/bin/perl Makefile.PL &&
make &&
make install &&
cd $SRCROOT && rm -rf $PDIR &&



### Getopt::Long
cd $SRCROOT && . ../../_functions.sh &&
export PNAME="Getopt-Long" &&
export PVERSION="2.38" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cpan.org/authors/id/J/JV/JV/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
$PDESTDIR_PERL/bin/perl Makefile.PL &&
make &&
make install &&
cd $SRCROOT && rm -rf $PDIR &&



### LWP
cd $SRCROOT && . ../../_functions.sh &&
export PNAME="libwww-perl" &&
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



### XML::SAX
# Missing prerequisite: XML::Namespaces
#cd $SRCROOT && . ../../_functions.sh &&
#export PNAME="XML-SAX" &&
#export PVERSION="0.96" &&
#export PDIR="$PNAME-$PVERSION" &&
#export PFILE="$PDIR.tar.gz" &&
#export PURI="http://www.cpan.org/authors/id/G/GR/GRANTM/$PFILE" &&
#rm -rf $PDIR &&
#GetUnpackCd &&
#$PDESTDIR_PERL/bin/perl Makefile.PL &&
#make &&
#make install &&
#cd $SRCROOT && rm -rf $PDIR &&



rm -rf /root/.cpan
