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



### DBD::Mysql
cd $SRCROOT && . ../../_functions.sh &&
export PNAME="DBD-mysql" &&
export PVERSION="4.020" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cpan.org/authors/id/C/CA/CAPTTOFU/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
$PDESTDIR_PERL/bin/perl Makefile.PL --mysql_config=$PDESTDIR_MYSQL/bin/mysql_config &&
make &&
make install &&
cd $SRCROOT && rm -rf $PDIR &&



### Percona-toolkit
# CheckURI: http://www.percona.com/downloads/percona-toolkit/
cd $SRCROOT && . ../../_functions.sh &&
export PNAME="percona-toolkit" &&
export PVERSION="2.0.2" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.percona.com/redir/downloads/percona-toolkit/$PVERSION/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
$PDESTDIR_PERL/bin/perl Makefile.PL &&
make &&
make install &&
cd $SRCROOT && rm -rf $PDIR &&



rm -rf /root/.cpan
