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
class   a2o_essential_linux_openssh::distro::a2o::base   inherits a2o_essential_linux_openssh::base {
}



### Service: sshd-sys
class   a2o_essential_linux_openssh::distro::a2o::service   inherits   a2o_essential_linux_openssh::distro::a2o::base {

    ### Requires and subscribes
    $require   = [
        File['/var/empty'],
        File['/var/run'],
    ]
    $subscribe = [
	Package['openssh'],
        File['/usr/local/openssh'],
        File['/usr/local/ssh'],
        File['/etc/ssh/sshd_config'],
    ]

    ### Instantiate from template
    a2o-essential-unix::rctool::service::generic { 'sshd':
	require   => $require,
	subscribe => $subscribe,
    }
}



### The final all-containing classes
class a2o_essential_linux_openssh::distro::a2o {
    include 'a2o_essential_linux_openssh::package'
    include 'a2o_essential_linux_openssh::files'
    include 'a2o_essential_linux_openssh::symlinks'
    include 'a2o_essential_linux_openssh::distro::a2o::service'
}
