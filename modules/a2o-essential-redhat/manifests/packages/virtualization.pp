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



### Required packages
class   a2o-essential-redhat::packages::virtualization   inherits   a2o-essential-redhat::packages::base {
    package { 'qemu-kvm':          }
    package { 'qemu-kvm-tools':    }
    package { 'qemu-img':          }
    package { 'python-virtinst':   }
    package { 'libvirt':           }
    package { 'libvirt-client':    }
}
