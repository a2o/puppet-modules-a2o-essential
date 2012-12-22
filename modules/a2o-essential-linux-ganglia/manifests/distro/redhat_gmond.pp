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



### Service: gmond
class   a2o-essential-linux-ganglia::distro::redhat_gmond::service   inherits   a2o-essential-linux-ganglia::distro::base_gmond {

    a2o-essential-redhat::service::rctool_wrapper { 'gmond':
        require   => $require,
        subscribe => $subscribe,
    }
}



### The final all-containing class
class a2o-essential-linux-ganglia::distro::redhat_gmond {

    include 'a2o-essential-linux-ganglia::distro::common_gmond'
    include 'a2o-essential-linux-ganglia::distro::redhat_gmond::service'
}
