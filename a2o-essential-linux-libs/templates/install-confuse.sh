### Init
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_CONFUSE="<%= packageSoftwareVersion %>" &&



### libconfuse
# CheckURI: http://bzero.se/confuse/
cd $SRCROOT && . ../_functions.sh &&
export PNAME="confuse" &&
export PVERSION="$PVERSION_CONFUSE" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://bzero.se/confuse/$PFILE" &&
rm -rf $PDIR &&
GetUnpackCd &&
cp src/Makefile.in src/Makefile.in.tmp &&
cat src/Makefile.in.tmp | sed -e 's/ -Werror//' > src/Makefile.in &&
cp src/Makefile.am src/Makefile.am.tmp &&
cat src/Makefile.am.tmp | sed -e 's/ -Werror//' > src/Makefile.am &&
CFLAGS="-O3 -fPIC" ./configure &&
make -j 2 &&
make install &&
ldconfig &&
cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
