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



### Service: redis
class   a2o_essential_linux_redis::distro::a2o::service   inherits   a2o_essential_linux_redis::base {

    $requireDefs = [
        File['/etc/redis/redis.conf-local'],
        File['/var/redis'],
        File['/var/redis/run'],
    ]
    $subscribeDefs = [
	Package['redis'],
        File['/usr/local/redis'],
        File['/etc/redis/redis.conf'],
    ]

    a2o-essential-unix::rctool::service::generic { 'redis':
        require   => $requireDefs,
        subscribe => $subscribeDefs,
    }
}



### Final all-containing class
class   a2o_essential_linux_redis::distro::a2o {
    include 'a2o_essential_linux_redis::package'
    include 'a2o_essential_linux_redis::files'
    include 'a2o_essential_linux_redis::users_groups'
    include 'a2o_essential_linux_redis::files_service'
    include 'a2o_essential_linux_redis::distro::a2o::service'
}
