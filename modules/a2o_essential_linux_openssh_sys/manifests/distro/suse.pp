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
class   a2o_essential_linux_openssh_sys::distro::suse::base   inherits a2o_essential_linux_openssh_sys::base {
}



### Service: sshd-sys
class   a2o_essential_linux_openssh_sys::distro::suse::service   inherits   a2o_essential_linux_openssh_sys::distro::suse::base {


    ### Requires and subscribes
    $require   = []
    $subscribe = [
	Package['openssh-sys'],
        File['/usr/local/openssh-sys'],
        File['/usr/local/ssh-sys'],
        File['/etc/ssh-sys/sshd_config'],
    ]

    ### Instantiate from template
    a2o-essential-suse::service::generic_withstartupfile { 'sshd-sys':
	require   => $require,
	subscribe => $subscribe,
    }
}



### The final all-containing classes
class a2o_essential_linux_openssh_sys::distro::suse {
    include 'a2o_essential_linux_openssh_sys::package'
    include 'a2o_essential_linux_openssh_sys::files'
    include 'a2o_essential_linux_openssh_sys::distro::suse::service'
}
