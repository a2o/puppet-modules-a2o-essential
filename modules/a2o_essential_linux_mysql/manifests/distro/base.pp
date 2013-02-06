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



### Service dependencies
class   a2o_essential_linux_mysql::distro::base   inherits   a2o_essential_linux_mysql::base {

    # Get external references
    $destDir_openssl = $a2o_essential_linux_mysql::package::mysql::externalDestDir_openssl


    $require   = [
        File['/var/mysql/binlog'],
        File['/var/mysql/data'],
        File['/var/mysql/log'],
        File['/var/mysql/run'],
        File['/var/mysql/tmp'],
        File['/etc/mysql/conf.d'],
    ]
    $subscribe = [
        Package['mysql'],
        File['/usr/local/mysql'],
        File['/etc/mysql/my.cnf'],
        File['/opt/scripts/mysql/mysql.server'],
    ]
}
