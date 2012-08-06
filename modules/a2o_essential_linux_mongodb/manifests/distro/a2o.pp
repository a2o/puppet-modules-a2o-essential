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



### Service: mongodb
class   a2o_essential_linux_mongodb::distro::a2o::service   inherits   a2o_essential_linux_mongodb::base {

    $requireDefs = [
        File['/var/mongodb/data'],
        File['/var/mongodb/run'],
    ]
    $subscribeDefs = [
	Package['mongodb'],
        File['/usr/local/mongodb'],
        File['/etc/mongodb/mongod.conf'],
    ]

    a2o-essential-unix::rctool::service::generic { 'mongod':
        require   => $requireDefs,
        subscribe => $subscribeDefs,
    }
}



### Final all-containing class
class   a2o_essential_linux_mongodb::distro::a2o {
    include 'a2o_essential_linux_mongodb::package'
    include 'a2o_essential_linux_mongodb::files'
    include 'a2o_essential_linux_mongodb::users_groups'
    include 'a2o_essential_linux_mongodb::files_service'
    include 'a2o_essential_linux_mongodb::distro::a2o::service'
}
