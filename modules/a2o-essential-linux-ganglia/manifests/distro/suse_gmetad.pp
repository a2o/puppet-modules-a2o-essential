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



### Service: gmetad
class   a2o-essential-linux-ganglia::distro::suse_gmetad::service   inherits   a2o-essential-linux-ganglia::base {

    $require   = [
        File['/etc/ganglia/gmetad.conf'],
        File['/var/ganglia/rrds'],
    ]

    $subscribe = [
        Package['ganglia'],
        Service['a2o-essential-linux-rrdcached'],
        File['/usr/local/ganglia'],
        File['/etc/ganglia/gmetad.conf'],
    ]

    a2o-essential-suse::service::rctool_wrapper { 'gmetad':
        require   => $require,
        subscribe => $subscribe,
    }
}



### The final all-containing classes
class a2o-essential-linux-ganglia::distro::suse_gmetad {
    include 'a2o-essential-linux-ganglia::users'
    include 'a2o-essential-linux-ganglia::package'
    include 'a2o-essential-linux-ganglia::files'
    include 'a2o-essential-linux-ganglia::files::gmetad'
    include 'a2o-essential-linux-ganglia::distro::suse_gmetad::service'
}
