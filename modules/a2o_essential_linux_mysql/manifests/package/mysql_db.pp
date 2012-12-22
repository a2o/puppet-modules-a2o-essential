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



### Software package: mysql db installation
class   a2o_essential_linux_mysql::package::mysql_db   inherits   a2o_essential_linux_mysql::package::base {

    # Package / Software details
    # CheckURI: http://ftp.arnes.si/mysql/Downloads/
    $softwareName     = 'mysql-db'
    $softwareVersion  = '0.1.0'
    $packageRelease   = '1'
    $packageTag       = "$softwareName-$softwareVersion-$packageRelease"


    ### Additional external data
    $destDir_mysql    = $a2o_essential_linux_mysql::package::mysql::destDir


    ### Package
    $require = [
        Package['mysql'],
        File['/usr/local/mysql'],
	Class['a2o_essential_linux_mysql::files::daemon'],
        File['/etc/rc.d/rc.mysqld'],
    ]
    a2o-essential-unix::compiletool::package::generic { "$packageTag": require => $require }


    $serviceName = 'a2o-linux-mysqld'
    Package["$softwareName"] -> Service["$serviceName"]
}
