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



### Required users and groups
class   a2o_essential_linux_redis::users_groups {

    group { 'redis':
	ensure     => present,
	gid        => 6379,
    }

    User  {
        provider   => useradd,
        allowdupe  => false,
	ensure     => present,
        password   => '*',
        shell      => '/bin/bash',
        managehome => true,
    }
    user  { 'redis':   require => Group['redis'], uid => 6379, gid => 6379, home => '/var/redis' }
}
