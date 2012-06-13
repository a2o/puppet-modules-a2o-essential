#!/bin/bash



# Compile directory
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_NAGIOS="<%= softwareVersion %>" &&
export PDESTDIR_NAGIOS="<%= destDir %>" &&
export PDESTDIR_PERL="<%= externalPackageDestDir_perl %>" &&



### Download and install
# CheckURI: http://www.nagios.org/download/core/thanks/
cd $SRCROOT && . ../_functions.sh &&
export PNAME="nagios" &&
export PVERSION="$PVERSION_NAGIOS" &&
export PDIR="$PNAME" &&
export PFILE="$PDIR-$PVERSION.tar.gz" &&
export PURI="http://garr.dl.sourceforge.net/sourceforge/nagios/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

wget http://source.a2o.si/patches/nagios-3.3.1-html-fix.diff &&
cat nagios-3.3.1-html-fix.diff | patch -p0 &&

./configure --prefix=$PDESTDIR_NAGIOS --sysconfdir=/etc/nagios --localstatedir=/var/nagios \
  --enable-embedded-perl \
  --with-checkresult-dir=/var/nagios/checkresults \
  --with-lockfile=/var/nagios/run/nagios.lock \
  --with-perlcache &&

make all &&
make install &&
make install-commandmode &&

cd $SRCROOT &&
rm -rf $PDIR
