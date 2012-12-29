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
export PDESTDIR="<%= destDir %>" &&
export GITREF_RBENV="<%= gitRef_rbenv %>" &&
export GITREF_RUBYBUILD="<%= gitRef_rubyBuild %>" &&



### RbEnv
rm -rf $PDESTDIR &&
git clone git://github.com/sstephenson/rbenv.git $PDESTDIR &&
cd $PDESTDIR &&
git checkout $GITREF_RBENV &&

# Fix path export, so we don't have to do anything else later on
# (not required, we fixed symlinks location below)
#sed -i -e 's#shims:\$#shims:/usr/local/rbenv/bin:$#' libexec/rbenv-init

# Prepare directory for plugins
mkdir -p plugins &&



### Ruby-build
git clone git://github.com/sstephenson/ruby-build.git plugins/ruby-build &&
cd plugins/ruby-build &&
git checkout $GITREF_RUBYBUILD &&
cd ../.. &&

ln -s ../plugins/ruby-build/bin/rbenv-install   libexec/rbenv-install   &&
ln -s ../plugins/ruby-build/bin/rbenv-uninstall libexec/rbenv-uninstall &&
ln -s ../plugins/ruby-build/bin/ruby-build      libexec/ruby-build      &&



true
