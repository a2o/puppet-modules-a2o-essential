#!/bin/bash



### Compile directory
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_PERCONA=`echo '<%= softwareVersion %>' | sed -e 's/_/-/'` &&
export PVERSION_MYSQL=`echo "$PVERSION_PERCONA" | cut -d'-' -f1` &&
export PVERSION_MYSQL_MAJOR=`echo "$PVERSION_MYSQL" | cut -d. -f1,2` &&
export PDESTDIR="<%= destDir %>" &&
export PDESTDIR_OPENSSL="<%= externalDestDir_openssl %>" &&



### MySQL Percona Fork
cd $SRCROOT && . /var/src/_functions.sh &&
export PNAME="Percona-Server" &&
export PVERSION="$PVERSION_MYSQL" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.percona.com/redir/downloads/Percona-Server-$PVERSION_MYSQL_MAJOR/Percona-Server-$PVERSION_PERCONA/source/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

./configure --prefix=$PDESTDIR --with-sysconfdir=/etc/mysql-percona \
  --with-charset=utf8 --with-collation=utf8_general_ci \
  --with-unix-socket-path=/var/mysql/run/mysql.sock \
  --with-mysqld-user=mysql \
  --with-ssl=$PDESTDIR_OPENSSL \
  --with-plugin-heap \
  --with-plugin-innobase \
  --with-plugin-myisam &&
# This is currently not required, see here at the bottom:
# http://dev.mysql.com/doc/refman/5.1/en/source-configuration-options.html#option_configure_with-plugins
#  --with-plugins=partition,archive,blackhole,csv,federated,heap,innobase,myisam,myisammrg \
make -j 2 &&
make install &&

cd $SRCROOT &&
rm -rf $PDIR



### Check if installation was successfull
if [ "$?" != "0" ]; then
    echo "ERROR: Installation failed"
    exit 1
fi



### Upgrade database
# FIXME change to mysql_fix_privilege_tables?
#export USER="root" &&
#export HOME="/root" &&
if [ -e /var/mysql/data/mysql ]; then
    $PDESTDIR/bin/mysql_upgrade --defaults-file=/root/.my.cnf
    if [ "$?" != "0" ]; then
	RES=`$PDESTDIR/bin/mysql_upgrade | grep -c "is already upgraded"`
	if [ "$RES" == "1" ]; then
	    exit 0
	else
	    echo "ERROR: Database upgrade failed"
	    exit 1
	fi
    fi
fi
