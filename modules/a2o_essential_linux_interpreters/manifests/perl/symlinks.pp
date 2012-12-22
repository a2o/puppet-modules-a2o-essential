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



### Symlinks for: perl
class   a2o_essential_linux_interpreters::perl::symlinks   inherits   a2o_essential_linux_interpreters::perl::base {

    File {
	require  => File['/usr/local/perl'],
	backup   => false,
    }

    # Program symlinks
    file { '/usr/local/bin/perl':   ensure => '/usr/local/perl/bin/perl' }
    file { '/usr/bin/perl':         ensure => '/usr/local/bin/perl'      }
}
