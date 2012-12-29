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



### Symlinks for: rbenv
class   a2o_essential_linux_interpreters::ruby::symlinks::rbenv   inherits   a2o_essential_linux_interpreters::ruby::base {

    File {
	require  => File['/usr/local/rbenv'],
	backup   => false,
    }

    # Program symlinks
    file { '/usr/local/bin/rbenv':   ensure => '/usr/local/rbenv/bin/rbenv' }
}
