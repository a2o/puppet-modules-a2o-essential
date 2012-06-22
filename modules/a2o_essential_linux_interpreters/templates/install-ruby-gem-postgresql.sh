#!/bin/bash



# Compile directory
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions, releases and directories
export PDESTDIR_RUBY="<%=  destDir_ruby %>" &&
export PDESTDIR_POSTGRESQL="<%=  externalDestDir_postgresql  %>" &&



### PostgreSQL C bindings
$PDESTDIR_RUBY/bin/gem install --no-ri --no-rdoc pg -- --with-pg-dir=$PDESTDIR_POSTGRESQL &&



exit 0
