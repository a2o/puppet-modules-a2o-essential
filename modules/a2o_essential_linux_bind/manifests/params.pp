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



### Module Parameters
#
# WARNING: This class must not inherit base class, it is the other way around
#
class   a2o_essential_linux_bind::params {

    $acl_recursion = ['127.0.0.1', $::ipaddress ]
    $acl_transfer  = ['127.0.0.1' ]

    $serviceName = $::operatingsystem ? {
	/(?i:Slackware)/                       => 'a2o-linux-named',
	/(?i:RedHat|Centos|Scientific|Fedora)/ => 'named',
	default                                => 'named',
  }
}
