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



### Set python path
export PATH="$PDESTDIR_PYTHON/bin:$PATH" &&



### Install easily
$PDESTDIR_PYTHON/bin/easy_install   txamqp   &&
$PDESTDIR_PYTHON/bin/easy_install   carbon   &&
$PDESTDIR_PYTHON/bin/easy_install   twisted  &&
$PDESTDIR_PYTHON/bin/easy_install   tagging  &&
$PDESTDIR_PYTHON/bin/easy_install   whisper  &&



### Install hardcore manually
# FIXME missing pycairo,memcache



true
