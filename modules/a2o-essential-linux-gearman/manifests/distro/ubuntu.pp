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



### Service: gearmand
class   a2o-essential-linux-gearman::distro::ubuntu::service   inherits   a2o-essential-linux-gearman::base {

    ### Requires and subscribes
    $require   = [
        File['/var/gearman'],
        File['/var/gearman/run'],
    ]
    $subscribe = [
        Package['gearman'],
	File['/usr/local/gearman'],
    ]


    ### Service
    a2o-essential-debian::service::rctool_wrapper { 'gearmand':
	require   => $require,
	subscribe => $subscribe,
    }
}



### Final all-containing class
class a2o-essential-linux-gearman::distro::ubuntu {
    include 'a2o-essential-linux-gearman'
    include 'a2o-essential-linux-gearman::distro::ubuntu::service'
}
