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
export PVERSION_SW="<%= packageSoftwareVersion %>" &&
export PDESTDIR_OPENSSL="<%= externalDestDir_openssl %>" &&



### TCPdump
# CheckURI: http://www.tcpdump.org/#latest
# Req: libpcap
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="tcpdump" &&
export PVERSION="$PVERSION_SW" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://www.tcpdump.org/release/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

# FIXME remove - bugfix - missing ppi.h
cat <<EOF > ppi.h &&
typedef struct ppi_header {
    uint8_t		ppi_ver;
    uint8_t		ppi_flags;
    uint16_t	ppi_len;
    uint32_t	ppi_dlt;
} ppi_header_t;

#define	PPI_HDRLEN	8
EOF

./configure --disable-smb &&
make &&
make install &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
