#!/bin/bash



# Compile directory
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_GANGLIA="<%= packageVersion %>" &&
export PDESTDIR="<%= destDir %>" &&
export PDESTDIR_PYTHON="<%= externalPackageDestDir_python %>" &&


### ganglia - gmond
# CheckURI: http://sourceforge.net/project/showfiles.php?group_id=43021&package_id=35280
# Req: libconfuse
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="ganglia" &&
export PVERSION="$PVERSION_GANGLIA" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://mesh.dl.sourceforge.net/sourceforge/ganglia/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

# Patch to disable collection of br* net interface metrics
wget http://source.a2o.si/patches/ganglia-3.1.7-ignore_br.diff &&
cat ganglia-3.1.7-ignore_br.diff | patch -p1 &&

# Patch to fix interface data collection on 32bit systems with if drivers that have 
# greater traffic counter than 32bit int
wget http://source.a2o.si/patches/ganglia-3.1.7-net_if_long_long.diff &&
cat ganglia-3.1.7-net_if_long_long.diff | patch -p1 &&

export PKG_CONFIG_PATH='/usr/local/lib/pkgconfig' &&
# FIXME should this be removed for all distributions?
export LD_LIBRARY_PATH="$PDESTDIR_PYTHON/lib" &&
export LDFLAGS="-L$PDESTDIR_PYTHON/lib" &&
#export LIBS='-lpython2.6' &&

# Search for APR
export APR_1_CONFIG_PATH=`PATH="/usr/local/apr/bin:$PATH" which apr-1-config` &&

./configure --prefix=$PDESTDIR --sysconfdir=/etc/ganglia \
  --enable-setuid=ganglia \
  --enable-setgid=ganglia \
  --with-python=$PDESTDIR_PYTHON/bin/python \
  --with-libapr=$APR_1_CONFIG_PATH &&
make CPPFLAGS=-DREMOVE_BOGUS_SPIKES &&

# Let's preserve original gmetad config file
export CURRENTFILE="/etc/ganglia/gmetad.conf" &&
export BACKUPDATE=`date +%Y%m%d-%H%M%S` &&
export BACKUPFILE="$CURRENTFILE-$BACKUPDATE" &&
if [ -e $CURRENTFILE ]; then
    cp $CURRENTFILE $BACKUPFILE
fi &&

make install &&

if [ -e $BACKUPFILE ]; then
    mv $BACKUPFILE $CURRENTFILE
fi &&


unset LIBS &&
unset PKG_CONFIG_PATH &&


cd $SRCROOT &&
rm -rf $PDIR