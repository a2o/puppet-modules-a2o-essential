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



### Set versions, releases and directories
export PDESTDIR_RUBY="<%=  destDir_ruby %>" &&



### Various gems
# Rails
# This version is not required anymore, right?
#$PDESTDIR_RUBY/bin/gem install --no-ri --no-rdoc rails --version 2.3.4 &&
$PDESTDIR_RUBY/bin/gem install --no-ri --no-rdoc rails --version 3.2.6 &&
$PDESTDIR_RUBY/bin/gem install --no-ri --no-rdoc rack  --version 1.1.3 &&

# Web servers
$PDESTDIR_RUBY/bin/gem install --no-ri --no-rdoc thin &&
$PDESTDIR_RUBY/bin/gem install --no-ri --no-rdoc unicorn &&

# OpenId
$PDESTDIR_RUBY/bin/gem install --no-ri --no-rdoc ruby-openid &&

# Internationalisation
$PDESTDIR_RUBY/bin/gem install --no-ri --no-rdoc -v=0.4.2 i18n &&

# For mcollective
$PDESTDIR_RUBY/bin/gem install --no-ri --no-rdoc stomp &&
$PDESTDIR_RUBY/bin/gem install --no-ri --no-rdoc psych &&
$PDESTDIR_RUBY/bin/gem install --no-ri --no-rdoc net-ping &&
$PDESTDIR_RUBY/bin/gem install --no-ri --no-rdoc sys-proctable &&
#$PDESTDIR_RUBY/bin/gem install --no-ri --no-rdoc ruby-debug && # Only for mc-debugger

# For Redmine 1.4.x
$PDESTDIR_RUBY/bin/gem install --no-ri --no-rdoc bundler &&
# TODO install ruby modules
# This should be run in an (Redmine) application directory
#$PDESTDIR_RUBY/bin/bundle install --without development test postgresql sqlite rmagick &&

# Capistrano
$PDESTDIR_RUBY/bin/gem install --no-ri --no-rdoc capistrano &&



exit 0
