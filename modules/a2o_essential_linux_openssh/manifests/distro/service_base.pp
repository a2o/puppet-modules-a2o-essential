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



### Service base
class   a2o_essential_linux_openssh::distro::service_base   inherits   a2o_essential_linux_openssh::package::base {

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
}
