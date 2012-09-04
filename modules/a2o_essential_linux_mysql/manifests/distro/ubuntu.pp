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



### Service: mysql FIXME change to upstart
class   a2o_essential_linux_mysql::distro::ubuntu::service   inherits   a2o_essential_linux_mysql::base {

    # Get external references
    $externalDestDir_openssl = $a2o_essential_linux_mysql::package::mysql::externalDestDir_openssl


    $require   = [
        File['/var/mysql/data'],
        File['/var/mysql/log'],
        File['/var/mysql/run'],
        File['/var/mysql/tmp'],
    ]
    $subscribe = [
	Package['mysql'],
#	Package['mysql-db'],
#	Package['mysql-db-users'],
        File['/usr/local/mysql'],
        File['/etc/mysql/my.cnf'],
    ]

    a2o-essential-unix::rctool::service::generic { 'mysqld':
        require   => $require,
        subscribe => $subscribe,
    }
}



### The final all-containing classes
class a2o_essential_linux_mysql::distro::ubuntu {
    include 'a2o_essential_linux_mysql::package'
    include 'a2o_essential_linux_mysql::files'
    include 'a2o_essential_linux_mysql::users_groups'
    include 'a2o_essential_linux_mysql::distro::ubuntu::service'
}
