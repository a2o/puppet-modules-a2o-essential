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



### Helper files
class   a2o_essential_linux_statsd::files   inherits   a2o_essential_linux_statsd::base {

    # Template
    File {
        owner    => root,
        group    => root,
	require  => [
	    Package['statsd'],
	    File['/usr/local/statsd'],
	],
    }

    # Symlinks
#    file { '/usr/local/bin/node':   ensure => '/usr/local/statsd/bin/node', }
#    file { '/usr/bin/node':         ensure => '/usr/local/bin/node',        }

    # FIXME this was a mistake, remove after 2012-08-8
#    file { '/usr/local/bin/statsd':   ensure => absent }
}
