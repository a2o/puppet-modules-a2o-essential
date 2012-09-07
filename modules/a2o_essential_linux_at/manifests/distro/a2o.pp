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



### Base class
class   a2o_essential_linux_at::distro::a2o::base   inherits a2o_essential_linux_at::base {
}



### Service: at
class   a2o_essential_linux_at::distro::a2o::service   inherits   a2o_essential_linux_at::distro::a2o::base {

    ### Requires and subscribes
    $require   = [
#        File['/var/spool/cron/atjobs'],
#        File['/var/spool/cron/atspool'],
#        Package['ntp'],
    ]
    $subscribe = [
	Package['at'],
#        File['/etc/at.deny'],
    ]

    ### Instantiate from template
    a2o-essential-unix::rctool::service::generic { 'atd':
	require   => $require,
	subscribe => $subscribe,
    }
}



### The final all-containing classes
class a2o_essential_linux_at::distro::a2o {
    include 'a2o_essential_linux_at::package::at'
    include 'a2o_essential_linux_at::distro::a2o::service'
}
