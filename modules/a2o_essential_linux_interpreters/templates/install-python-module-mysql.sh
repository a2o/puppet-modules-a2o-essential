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
export PDESTDIR_PYTHON="<%= destDir_python %>" &&
export PDESTDIR_MYSQL="<%=  externalDestDir_mysql  %>" &&
export PVERSION_MODULE="<%= softwareVersion %>" &&



### Set python path
export PATH="$PDESTDIR_PYTHON/bin:$PATH" &&
export LD_LIBRARY_PATH="$PDESTDIR_PYTHON/lib" &&



### Python MySQL module
# CheckURI: http://pypi.python.org/pypi/MySQL-python
cd $SRCROOT && . /var/src/build_functions.sh &&
export PNAME="MySQL-python" &&
export PVERSION="$PVERSION_MODULE" &&
export PDIR="$PNAME-$PVERSION" &&
export PFILE="$PDIR.tar.gz" &&
export PURI="http://pypi.python.org/packages/source/M/MySQL-python/$PFILE" &&

rm -rf $PDIR &&
GetUnpackCd &&

# Configure it
echo "" >> site.cfg &&
echo "mysql_config=$PDESTDIR_MYSQL/bin/mysql_config" >> site.cfg &&

$PDESTDIR_PYTHON/bin/python setup.py install &&

cd $SRCROOT &&
rm -rf $PDIR &&



true
