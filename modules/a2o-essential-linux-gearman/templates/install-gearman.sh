
### Init
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Versions
export PVERSION_GEARMAN="<%= packageSoftwareVersion %>" &&
export PDESTDIR="<%= destDir %>" &&



### Gearmand
# CheckURI: http://gearman.org/index.php?id=download
cd $SRCROOT && . ../_functions.sh &&
export PNAME="gearmand" &&
export PVERSION="$PVERSION_GEARMAN" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://launchpad.net/gearmand/trunk/$PVERSION/+download/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure --prefix=$PDESTDIR &&
make &&
make install &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
