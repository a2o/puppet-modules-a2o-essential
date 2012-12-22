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



### Service: mysql
class   a2o_essential_linux_mysql::distro::ubuntu::service   inherits   a2o_essential_linux_mysql::distro::base {

    a2o-essential-debian::service::rctool_wrapper { 'mysqld':
        require   => $require,
        subscribe => $subscribe,
    }
}



### The final all-containing classes
class   a2o_essential_linux_mysql::distro::ubuntu {

    include 'a2o_essential_linux_mysql::distro::common'
    include 'a2o_essential_linux_mysql::distro::ubuntu::service'
}
