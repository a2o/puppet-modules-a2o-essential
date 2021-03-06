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



### Service dependencies
class   a2o_essential_linux_redis::distro::service_base   inherits   a2o_essential_linux_redis::base {

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
}
