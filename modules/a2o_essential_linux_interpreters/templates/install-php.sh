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
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions, releases and directories
export PVERSION_PHP="<%=        softwareVersion   %>" &&
export PDESTDIR_PHP="<%=        destDir       %>" &&

export PDESTDIR_OPENSSL="<%=    externalDestDir_openssl    %>" &&
export PDESTDIR_OPENLDAP="<%=   externalDestDir_openldap   %>" &&
export PDESTDIR_CYRUSIMAP="<%=  externalDestDir_cyrusImap  %>" &&
export PDESTDIR_POSTGRESQL="<%= externalDestDir_postgresql %>" &&




### PHP
# CheckURI: http://www.php.net/
cd $SRCROOT && . /var/src/build_functions.sh &&
export PNAME="php" &&
export PVERSION="$PVERSION_PHP" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
#export PURI="http://php.net/get/$PFILE/from/this/mirror" &&
export PURI="http://php.net/distributions/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

export LD_LIBRARY_PATH="$PDESTDIR_OPENSSL/lib" &&

./configure --prefix=$PDESTDIR_PHP \
  --enable-cli --disable-cgi \
  --with-config-file-path=/etc/php/cli \
  --with-config-file-scan-dir=/etc/php/cli/conf.d \
  --enable-ipv6 \
  --disable-all \
  \
  --enable-libxml \
  --with-openssl=$PDESTDIR_OPENSSL \
  --with-pcre-regex \
  --with-sqlite3 \
  --with-zlib \
  --enable-bcmath \
  --with-bz2 \
  --enable-calendar \
  --enable-ctype \
  --with-curl \
  --enable-dba=shared --with-db4 --enable-inifile --enable-flatfile \
  --enable-dom --with-libxml-dir \
  --enable-exif \
  --enable-fileinfo \
  --enable-filter \
  --enable-ftp \
  --with-gd --with-jpeg-dir --with-png-dir --with-freetype-dir \
  --with-gettext \
  --with-gmp \
  --enable-hash --with-mcrypt \
  --with-iconv=/usr/local/lib --with-iconv-dir=/usr/local/lib \
  --with-imap=$PDESTDIR_CYRUSIMAP --with-imap-ssl \
  --enable-intl \
  --enable-json \
  --with-ldap=$PDESTDIR_OPENLDAP \
  --enable-mbstring --enable-mbregex --enable-mbregex-backtrack \
  --with-mssql \
  --with-mysql=mysqlnd --with-mysqli=mysqlnd \
  --with-unixODBC \
  --enable-pdo \
  --with-pdo-dblib \
  --with-pdo-mysql=mysqlnd \
  --with-pdo-sqlite --enable-sqlite-utf8 \
  --with-pdo-odbc=unixODBC \
  --with-pdo-pgsql=$PDESTDIR_POSTGRESQL \
  --with-pgsql=$PDESTDIR_POSTGRESQL \
  --enable-reflection \
  --enable-session \
  --enable-shmop \
  --enable-simplexml \
  --enable-soap \
  --enable-sockets \
  --enable-spl \
  --with-sqlite --enable-sqlite-utf8 \
  --with-regex=php \
  --enable-sysvmsg --enable-sysvsem --enable-sysvshm \
  --with-tidy \
  --enable-tokenizer \
  --enable-xml --enable-xmlreader --with-xmlrpc --enable-xmlwriter --with-xsl \
  --enable-zip \
  \
  --with-ncurses --enable-pcntl --enable-posix --with-readline \
  \
  --with-pear \
  --enable-zend-multibyte &&

make -j 2 &&
rm -f /root/.pearrc &&
make install &&

unset LD_LIBRARY_PATH &&

# Patch ELF in order to transparently load correct openssl
_patchelf_rpath_orderDesc $PDESTDIR_PHP/bin/php &&

cd $SRCROOT &&
rm -rf $PDIR &&



true
