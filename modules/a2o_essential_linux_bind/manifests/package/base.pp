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



### Software package base class
class   a2o_essential_linux_bind::package::base   inherits   a2o_essential_linux_bind::base {

    $compileDir = '/var/src/bind'

    file { "$compileDir":
	ensure => directory,
	owner  => root,
	group  => root,
	mode   => 755,
    }
}
