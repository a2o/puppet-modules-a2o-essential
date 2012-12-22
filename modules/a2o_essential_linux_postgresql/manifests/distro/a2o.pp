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



### Service: postgresql
class   a2o_essential_linux_postgresql::distro::a2o::service   inherits   a2o_essential_linux_postgresql::base {

    $requireDefs = [
        User['postgresql'],
        File['/etc/postgresql'],
        File['/var/postgresql/data'],
        File['/var/postgresql/log'],
        File['/var/postgresql/run'],
    ]
    $subscribeDefs = [
        Package['postgresql'],
        Package['postgresql-db'],
        File['/usr/local/postgresql'],
        File['/etc/postgresql/postgresql.conf'],
    ]

    a2o-essential-unix::rctool::service::generic { 'postgres':
        require   => $requireDefs,
        subscribe => $subscribeDefs,
    }
}



### Final all-containing class
class a2o_essential_linux_postgresql::distro::a2o {
    include 'a2o_essential_linux_postgresql::users_groups'
    include 'a2o_essential_linux_postgresql::package::cleanup'
    include 'a2o_essential_linux_postgresql::package::postgresql'
    include 'a2o_essential_linux_postgresql::package::postgresql_db'
    include 'a2o_essential_linux_postgresql::files'
    include 'a2o_essential_linux_postgresql::symlinks'
    include 'a2o_essential_linux_postgresql::distro::a2o::service'
}
