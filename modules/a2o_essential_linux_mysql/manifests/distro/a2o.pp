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
class   a2o_essential_linux_mysql::distro::a2o::service   inherits   a2o_essential_linux_mysql::distro::base {

    $requireA2o = [
	$require,
	File['/etc/ssl/certs/mysql.key'],
	File['/etc/ssl/certs/mysql.cert'],
    ]

    a2o-essential-unix::rctool::service::generic { 'mysqld':
        require   => $requireA2o,
        subscribe => $subscribe,
    }
}



### The final all-containing classes
class   a2o_essential_linux_mysql::distro::a2o {

    include 'a2o_essential_linux_mysql::distro::common'
    include 'a2o_essential_linux_mysql::package::mysql_db'
    include 'a2o_essential_linux_mysql::package::mytop'
    include 'a2o_essential_linux_mysql::files::mytop'
    include 'a2o_essential_linux_mysql::distro::a2o::service'
    include 'a2o_essential_linux_mysql::files::symlinks_lib'
    include 'a2o_essential_linux_mysql::crons'
}
