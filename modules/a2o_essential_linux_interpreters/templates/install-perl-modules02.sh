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
export PDESTDIR_MYSQL="<%=   externalDestDir_mysql   %>" &&



### Install modules
# CheckURI: http://www.cpan.org/modules/01modules.index.html



cd $SRCROOT && . ../../_functions.sh &&
export PNAME="Email-Address" &&
export PVERSION="1.892" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cpan.org/authors/id/R/RJ/RJBS/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
$PDESTDIR_PERL/bin/perl Makefile.PL &&
make &&
make install &&
cd $SRCROOT && rm -rf $PDIR &&



cd $SRCROOT && . ../../_functions.sh &&
export PNAME="Email-Valid" &&
export PVERSION="0.08" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cpan.org/authors/id/M/MA/MAURICE/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
$PDESTDIR_PERL/bin/perl Makefile.PL &&
make &&
make install &&
cd $SRCROOT && rm -rf $PDIR &&



cd $SRCROOT && . ../../_functions.sh &&
export PNAME="Log-Dispatch" &&
export PVERSION="2.29" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cpan.org/authors/id/D/DR/DROLSKY/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
$PDESTDIR_PERL/bin/perl Makefile.PL &&
make &&
make install &&
cd $SRCROOT && rm -rf $PDIR &&



cd $SRCROOT && . ../../_functions.sh &&
export PNAME="Log-Log4perl" &&
export PVERSION="1.33" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cpan.org/authors/id/M/MS/MSCHILLI/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
$PDESTDIR_PERL/bin/perl Makefile.PL &&
make &&
make install &&
cd $SRCROOT && rm -rf $PDIR &&



cd $SRCROOT && . ../../_functions.sh &&
export PNAME="MIME-Charset" &&
export PVERSION="1.009.1" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cpan.org/authors/id/N/NE/NEZUMI/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
printf "n" | $PDESTDIR_PERL/bin/perl Makefile.PL &&
make &&
make install &&
cd $SRCROOT && rm -rf $PDIR &&



cd $SRCROOT && . ../../_functions.sh &&
export PNAME="MIME-EncWords" &&
export PVERSION="1.012.3" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cpan.org/authors/id/N/NE/NEZUMI/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
$PDESTDIR_PERL/bin/perl Makefile.PL &&
make &&
make install &&
cd $SRCROOT && rm -rf $PDIR &&



cd $SRCROOT && . ../../_functions.sh &&
export PNAME="Mail-Sender" &&
export PVERSION="0.8.16" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cpan.org/authors/id/J/JE/JENDA/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
$PDESTDIR_PERL/bin/perl Makefile.PL &&
printf "n\n" | make &&
make install &&
cd $SRCROOT && rm -rf $PDIR &&



cd $SRCROOT && . ../../_functions.sh &&
export PNAME="MailTools" &&
export PVERSION="2.08" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cpan.org/authors/id/M/MA/MARKOV/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
$PDESTDIR_PERL/bin/perl Makefile.PL &&
make &&
make install &&
cd $SRCROOT && rm -rf $PDIR &&



cd $SRCROOT && . ../../_functions.sh &&
export PNAME="Params-Validate" &&
export PVERSION="1.00" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cpan.org/authors/id/D/DR/DROLSKY/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
$PDESTDIR_PERL/bin/perl Build.PL &&
./Build &&
./Build install &&
cd $SRCROOT && rm -rf $PDIR &&



cd $SRCROOT && . ../../_functions.sh &&
export PNAME="Test-Pod" &&
export PVERSION="1.45" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cpan.org/authors/id/D/DW/DWHEELER/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
$PDESTDIR_PERL/bin/perl Makefile.PL &&
make &&
make install &&
cd $SRCROOT && rm -rf $PDIR &&



cd $SRCROOT && . ../../_functions.sh &&
export PNAME="TimeDate" &&
export PVERSION="1.20" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cpan.org/authors/id/G/GB/GBARR/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
$PDESTDIR_PERL/bin/perl Makefile.PL &&
make &&
make install &&
cd $SRCROOT && rm -rf $PDIR &&



rm -rf /root/.cpan
