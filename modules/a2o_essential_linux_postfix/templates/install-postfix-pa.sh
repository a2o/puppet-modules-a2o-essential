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
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions and directories
export PVERSION_POSTFIX="<%= softwareVersion %>" &&
export PDESTDIR="<%= destDir %>" &&
export PVERSION_VDA="<%= softwareVersion_vda %>" &&
export PDESTDIR_OPENSSL="<%= destDir_openssl %>" &&
export PDESTDIR_MYSQL="<%= destDir_mysql %>" &&



### Postfix
# CheckURI: http://cdn.postfix.johnriley.me/mirrors/postfix-release/index.html
cd $SRCROOT && . ../_functions.sh &&
export PNAME="postfix" &&
export PVERSION="$PVERSION_POSTFIX" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://cdn.postfix.johnriley.me/mirrors/postfix-release/official/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

# Patch it with VDA patch
wget http://vda.sourceforge.net/VDA/postfix-vda-$PVERSION_VDA.patch &&
cat postfix-vda-$PVERSION_VDA.patch | patch -p1 &&

# Obligatory use of single quotes!
make makefiles \
  CCARGS='-DUSE_TLS -I<%= destDir_openssl %>/include -DUSE_SASL_AUTH -DHAS_MYSQL -I<%= destDir_mysql %>/include/mysql' \
  AUXLIBS="-lssl -lcrypto -L$PDESTDIR_OPENSSL/lib -lmysqlclient -lz -lm -L$PDESTDIR_MYSQL/lib" &&
make -j 2 &&
sh ./postfix-install -non-interactive \
  command_directory=$PDESTDIR/sbin \
  daemon_directory=$PDESTDIR/libexec/postfix \
  mailq_path=$PDESTDIR/bin/mailq \
  newaliases_path=$PDESTDIR/bin/newaliases \
  sendmail_path=$PDESTDIR/sbin/sendmail \
  data_directory=/var/postfix/data \
  queue_directory=/var/postfix/spool &&

cd $SRCROOT &&
rm -rf $PDIR &&



true
