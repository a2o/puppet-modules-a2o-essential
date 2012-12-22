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



### Base class
class   a2o_essential_linux_activemq::distro::suse::base   inherits a2o_essential_linux_activemq::base {
}



### Service: activemq
class   a2o_essential_linux_activemq::distro::suse::service   inherits   a2o_essential_linux_activemq::distro::suse::base {


    ### Requires and subscribes
    $require   = [
        File['/etc/activemq'],
        File['/opt/activemq'],
        File['/var/activemq'],
    ]
    $subscribe = [
	Package['activemq'],
        File['/usr/local/activemq'],
    ]

    ### Instantiate from template
    a2o-essential-suse::service::generic_withstartupfile { 'activemq':
	require   => $require,
	subscribe => $subscribe,
    }
}



### The final all-containing classes
class a2o_essential_linux_activemq::distro::suse {
    include 'a2o_essential_linux_activemq::package'
    include 'a2o_essential_linux_activemq::files'
    include 'a2o_essential_linux_activemq::distro::suse::service'
}
