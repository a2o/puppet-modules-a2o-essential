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



### Set versions and directories
export PVERSION_SW="<%= softwareVersion %>" &&
export PDESTDIR="<%= destDir %>" &&
export PDESTDIR_OPENSSL="<%= destDir_openssl %>" &&



### Postfix
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="postfix" &&
export PVERSION="$PVERSION_SW" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://cdn.postfix.johnriley.me/mirrors/postfix-release/official/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

# Patch with local delivery logging enhancements
wget http://source.a2o.si/patches/postfix-2.9.2-delivery_logging-0.1.patch.diff &&
patch -p1 < postfix-2.9.2-delivery_logging-0.1.patch.diff &&

# Force exact OpenSSL version
export LD_LIBRARY_PATH="$PDESTDIR_OPENSSL/lib" &&

# Obligatory use of single quotes!
make makefiles \
  CCARGS='-DUSE_TLS -I<%= destDir_openssl %>/include -DUSE_SASL_AUTH' \
  AUXLIBS="-lssl -lcrypto -L$PDESTDIR_OPENSSL/lib" &&
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
