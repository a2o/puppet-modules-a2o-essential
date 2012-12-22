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



### Software package: mysql
class   a2o_essential_linux_mysql::package::mysql_percona   inherits   a2o_essential_linux_mysql::package::base {

    # Package / Software details
    # CheckURI: http://www.percona.com/software/percona-server/downloads/
    $softwareName     = 'mysql-percona'
    $softwareVersion  = '5.1.62_13.3'
    $packageRelease   = '1'
    $packageTag       = "$softwareName-$softwareVersion-$packageRelease"
    $destDir          = "/usr/local/$packageTag"


    ### Additinal versions
    $externalDestDir_openssl = '/usr/local/openssl-1.0.0i-1'


    ### Package
    $require = [
        Package['openssl'],
    ]
    a2o-essential-unix::compiletool::package::generic { "$packageTag": require => $require, }


    # Startup script fixup - rearrange order of parameters
    file { "$destDir/share/mysql/mysql.server":
	content  => template("$thisPuppetModule/mysql-percona.server"),
	owner    => root,
	group    => root,
	mode     => 755,
	require  => [
	    Package["$softwareName"],
	],
    }


    ### Symlink
    file { "/usr/local/$softwareName":
	ensure  => "$packageTag",
	require => [
	    Package["$softwareName"],
	    File["$destDir/share/mysql/mysql.server"],
	],
	backup   => false,
    }
}
