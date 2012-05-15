#!/bin/bash



# Compile directory
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions, releases and directories
export PDESTDIR_RUBY="<%=  destDir_ruby %>" &&
export PDESTDIR_MYSQL="<%=  externalDestDir_mysql  %>" &&



### MySQL C bindings - required for better performance of Redmine
$PDESTDIR_RUBY/bin/gem install --no-ri --no-rdoc mysql -- --with-mysql-dir=$PDESTDIR_MYSQL &&



exit 0
