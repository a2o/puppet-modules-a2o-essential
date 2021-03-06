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



### Base class for distro-based service class for memcached
class   a2o_essential_linux_memcached::distro::base   inherits   a2o_essential_linux_memcached::base {

    $require   = [
        File['/var/run/memcached'],
    ]

    $subscribe = [
	Package['memcached'],
#        File['/usr/local/memcached'],
#	User['nobody'],
#	Group['nogorup'],
    ]
}
