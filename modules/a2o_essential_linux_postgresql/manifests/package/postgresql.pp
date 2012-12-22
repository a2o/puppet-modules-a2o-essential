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



### Software package: postgresql
class   a2o_essential_linux_postgresql::package::postgresql   inherits   a2o_essential_linux_postgresql::package::base {

    # Package / Software details
    # CheckURI: http://ftp.arnes.si/postgresql/Downloads/
    $softwareName     = 'postgresql'
    $softwareVersion  = '9.2.1'
    $packageRelease   = '1'
    $packageTag       = "$softwareName-$softwareVersion-$packageRelease"
    $destDir          = "/usr/local/$packageTag"


    ### Additinal versions
    $externalDestDir_openssl = '/usr/local/openssl-1.0.0i-1'


    ### Package
    $require = [
        Package['openssl'],
        Package['zlib'],
#        Package['readline'],
    ]
    a2o-essential-unix::compiletool::package::generic { "$packageTag": require => $require, }


    ### Symlink
    file { "/usr/local/$softwareName":
	ensure  => "$packageTag",
	require => [
	    Package["$softwareName"],
	],
	backup   => false,
    }
}
