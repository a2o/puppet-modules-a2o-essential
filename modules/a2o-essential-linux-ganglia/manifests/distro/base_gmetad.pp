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



### Service base: gmetad
class   a2o-essential-linux-ganglia::distro::base_gmetad   inherits   a2o-essential-linux-ganglia::base {

    # Get distro-dependent service name
    $rrdcachedServiceName = $operatingsystem ? {
	'slackware' => 'a2o-linux-rrdcached',
	default     => 'rrdcached',
    }

    $require   = [
        File['/var/ganglia/rrds'],
    ]

    $subscribe = [
        Package['ganglia'],
        Service[$rrdcachedServiceName],
        File['/usr/local/ganglia'],
        File['/etc/ganglia/gmetad.conf'],
    ]
}
