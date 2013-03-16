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



### Software package: mysql database schema/data upgrade
class   a2o_essential_linux_mysql::package::mysql_db_upgrade   inherits   a2o_essential_linux_mysql::package::base {

    # Get external variables
    $packageTag_mysql = $a2o_essential_linux_mysql::package::mysql::packageTag
    $destDir_mysql    = "/usr/local/${a2o_essential_linux_mysql::package::mysql::packageTag}"

    # Package / Software details
    $softwareName     = "$packageTag_mysql-mysql-db-upgrade"
    $softwareVersion  = '0.1.0'
    $packageRelease   = '1'
    $packageTag       = "$softwareName-$softwareVersion-$packageRelease"


    ### Package
    $require = [
        Package['mysql'],
        File['/usr/local/mysql'],
        Service["$serviceName"],
    ]
    a2o-essential-unix::compiletool::package::generic { "$packageTag":
	require             => $require,
	installScriptTplUri => "$thisPuppetModule/install-mysql-db-upgrade.sh",
    }
}
