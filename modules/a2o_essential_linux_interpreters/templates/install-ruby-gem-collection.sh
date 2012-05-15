#!/bin/bash



# Compile directory
export SRCROOT="<%= compileDir %>" &&
mkdir -p $SRCROOT &&
cd $SRCROOT &&



### Set versions, releases and directories
export PDESTDIR_RUBY="<%=  destDir_ruby %>" &&



### Various gems
# Rails
$PDESTDIR_RUBY/bin/gem install --no-ri --no-rdoc rails --version 2.3.4 &&
$PDESTDIR_RUBY/bin/gem install --no-ri --no-rdoc rack  --version 1.1.3 &&

# Thin web server
$PDESTDIR_RUBY/bin/gem install --no-ri --no-rdoc thin &&

# OpenId
$PDESTDIR_RUBY/bin/gem install --no-ri --no-rdoc ruby-openid &&

# Internationalisation
$PDESTDIR_RUBY/bin/gem install --no-ri --no-rdoc -v=0.4.2 i18n &&

# For mcollective
$PDESTDIR_RUBY/bin/gem install --no-ri --no-rdoc stomp &&
$PDESTDIR_RUBY/bin/gem install --no-ri --no-rdoc net-ping &&
$PDESTDIR_RUBY/bin/gem install --no-ri --no-rdoc sys-proctable &&
#$PDESTDIR_RUBY/bin/gem install --no-ri --no-rdoc ruby-debug && # Only for mc-debugger



exit 0
