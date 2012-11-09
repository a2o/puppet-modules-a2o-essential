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



### Service: rrdcached
class   a2o_essential_linux_rrdcached::distro::suse::service   inherits   a2o_essential_linux_rrdcached::distro::service_base {

    a2o-essential-suse::service::rctool_wrapper { 'rrdcached':
        require   => $require,
        subscribe => $subscribe,
    }
}



### Final all-containing class
class   a2o_essential_linux_rrdcached::distro::suse {
    include 'a2o_essential_linux_rrdcached::distro::common'
    include 'a2o_essential_linux_rrdcached::distro::suse::service'
}
