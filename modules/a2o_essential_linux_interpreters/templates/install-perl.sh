#!/bin/bash



# Compile directory
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions, releases and directories
export PVERSION_PERL="<%=    softwareVersion   %>" &&
export PDESTDIR_PERL="<%=    destDir %>" &&

export PDESTDIR_OPENSSL="<%= externalDestDir_openssl   %>" &&
export PDESTDIR_MYSQL="<%=   externalDestDir_mysql     %>" &&



### Perl
# CheckURI: http://www.php.net/downloads.php
cd $SRCROOT && . ../_functions.sh &&
export PNAME="perl" &&
export PVERSION="$PVERSION_PERL" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.cpan.org/src/5.0/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure.gnu -Dprefix=$PDESTDIR_PERL -Dusethreads -Duseshrplib &&
make -j 2 &&
make install &&

cd $SRCROOT &&
rm -rf $PDIR
