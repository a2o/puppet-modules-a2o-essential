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
class   a2o_essential_linux_keepalived::distro::a2o::base   inherits a2o_essential_linux_keepalived::package::base {
}



### Service: keepalived
class   a2o_essential_linux_keepalived::distro::a2o::service   inherits   a2o_essential_linux_keepalived::distro::a2o::base {

    ### Requires and subscribes
    $require   = [
    ]
    $subscribe = [
	Package['keepalived'],
    ]

    ### Instantiate from template
    a2o-essential-unix::rctool::service::generic { 'keepalived':
	require   => $require,
	subscribe => $subscribe,
    }
}



### The final all-containing classes
class a2o_essential_linux_keepalived::distro::a2o {
    include 'a2o_essential_linux_keepalived::package::keepalived'
    include 'a2o_essential_linux_keepalived::files'
    include 'a2o_essential_linux_keepalived::distro::a2o::service'
}
