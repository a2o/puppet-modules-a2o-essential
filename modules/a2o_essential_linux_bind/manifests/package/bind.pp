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



### Software package: bind
class   a2o_essential_linux_bind::package::bind   inherits   a2o_essential_linux_bind::package::base {

    # CheckURI: https://www.isc.org/downloadables/11
    # INFO: If there is a version with dash in it (9.9.1-P1), enter it with an
    # INFO: underscore: 9.9.1_P1.
    $softwareName     = 'bind'
    $softwareVersion  = '9.9.2_P1'
    $packageRelease   = '2'
    $packageTag       = "$softwareName-$softwareVersion-$packageRelease"
    $destDir          = "/usr/local/$packageTag"

    # Extenal references
    $destDir_openssl  = '/usr/local/openssl-1.0.1e-2'


    ### Package
    $require = [
	Package['openssl'],
	User['named'],
    ]
    a2o-essential-unix::compiletool::package::generic { "$packageTag": require => $require }


    ### Symlink
    file { "/usr/local/$softwareName":
	ensure  => "$packageTag",
	require => [
	    Package["$softwareName"],
        ],
        backup   => false,
    }
}
