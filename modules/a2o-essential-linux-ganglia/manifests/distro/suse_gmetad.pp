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



### Service: gmetad
class   a2o-essential-linux-ganglia::distro::suse_gmetad::service   inherits   a2o-essential-linux-ganglia::distro::base_gmetad {

    a2o-essential-suse::service::rctool_wrapper { 'gmetad':
        require   => $require,
        subscribe => $subscribe,
    }
}



### The final all-containing class
class a2o-essential-linux-ganglia::distro::suse_gmetad {

    include 'a2o-essential-linux-ganglia::distro::common_gmetad'
    include 'a2o-essential-linux-ganglia::distro::suse_gmetad::service'
}
