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



### Service: collectd
class   a2o_essential_linux_collectd::distro::a2o::service   inherits   a2o_essential_linux_collectd::package::base {

    ### Additional dependencies
    Package['rrdtool'] -> Package['collectd']

    ### Requires and subscribes
    $require   = [
        File['/etc/collectd.d'],
        File['/etc/collectd.d/PLACEHOLDER.conf'],
        File['/var/collectd'],
    ]
    $subscribe = [
	Package['collectd'],
        File['/usr/local/collectd'],
        File['/etc/collectd.conf'],
    ]

    ### Instantiate from template
    a2o-essential-unix::rctool::service::generic { 'collectd':
	require   => $require,
	subscribe => $subscribe,
    }
}



### The final all-containing classes
class a2o_essential_linux_collectd::distro::a2o {
    include 'a2o_essential_linux_collectd::package'
    include 'a2o_essential_linux_collectd::files'
    include 'a2o_essential_linux_collectd::files::daemon_a2o'
    include 'a2o_essential_linux_collectd::distro::a2o::service'
}
