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
export PVERSION_SW="<%= packageSoftwareVersion %>" &&
export PDESTDIR_OPENSSL="<%= externalDestDir_openssl %>" &&



### PCIutils - ker za KVM nucas shared library
# CheckURI: ftp://atrey.karlin.mff.cuni.cz/pub/linux/pci/
cd $SRCROOT && . ../build_functions.sh &&
export PNAME="pciutils" &&
export PVERSION="$PVERSION_SW" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="ftp://atrey.karlin.mff.cuni.cz/pub/linux/pci/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

make ZLIB=no SHARED=no &&
(
  removepkg pciutils;
  make PREFIX=/usr install;
  make PREFIX=/usr install-lib
) &&
make distclean &&
make ZLIB=no SHARED=yes &&
(
  removepkg pciutils;
  make PREFIX=/usr install &&
  make PREFIX=/usr install-lib &&
  ldconfig &&
  export LD_LIBRARY_PATH=$PDESTDIR_OPENSSL/lib &&
  ./update-pciids &&
  unset LD_LIBRARY_PATH
) &&

cd $SRCROOT &&
rm -rf $PDIR &&



exit 0
