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



### Service: libvirtd
class   a2o_essential_linux_kvm::distro::a2o::service_libvirtd   inherits   a2o_essential_linux_kvm::distro::service_base_libvirtd {

    a2o-essential-unix::rctool::service::generic { 'libvirtd':
        require   => $require,
        subscribe => $subscribe,
    }
}



### Final all-containing class
class   a2o_essential_linux_kvm::distro::a2o {
    include 'a2o_essential_linux_kvm::distro::common'
#    include 'a2o_essential_linux_kvm::distro::a2o::service_libvirtd'
}
