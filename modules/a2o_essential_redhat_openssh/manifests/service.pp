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



### Service: ssh
class   a2o_essential_redhat_openssh::service   inherits   a2o_essential_redhat_openssh::base {

    a2o-essential-redhat::service::generic { 'sshd':
	require   => [
	    Package['openssh'],
	    Package['openssh-server'],
	],
	subscribe => [
	    File['/etc/ssh/sshd_config'],
	],
    }
}
