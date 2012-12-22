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



### Symlinks for: perl modules
class   a2o_essential_linux_interpreters::perl::symlinks_modules   inherits   a2o_essential_linux_interpreters::perl::base {

    File {
	require  => File['/usr/local/perl'],
	backup   => false,
    }

    # Module program symlinks
    file { '/usr/local/bin/pod2man':      ensure => '/usr/local/perl/bin/pod2man'    }
    file { '/usr/local/bin/pod2html':     ensure => '/usr/local/perl/bin/pod2html'   }
    file { '/usr/local/bin/podchecker':   ensure => '/usr/local/perl/bin/podchecker' }
}
