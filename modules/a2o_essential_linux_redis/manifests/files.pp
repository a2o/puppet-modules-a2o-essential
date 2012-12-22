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



### Helper files
class   a2o_essential_linux_redis::files   inherits   a2o_essential_linux_redis::base {

    # Template
    File {
        owner    => root,
        group    => root,
	require  => [
	    Package['redis'],
	    File['/usr/local/redis'],
	],
    }

    # Symlinks
    file { '/usr/local/bin/redis-benchmark':    ensure => '/usr/local/redis/bin/redis-benchmark',  }
    file { '/usr/local/bin/redis-check-dump':   ensure => '/usr/local/redis/bin/redis-check-dump', }
    file { '/usr/local/bin/redis-cli':          ensure => '/usr/local/redis/bin/redis-cli',        }
}
