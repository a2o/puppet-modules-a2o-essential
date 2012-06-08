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



### Software package: activemq
class   a2o_essential_linux_activemq::package::activemq   inherits   a2o_essential_linux_activemq::package::base {

    # Package / Software details
    # CheckURI: http://ftp.arnes.si/activemq/Downloads/
    $softwareName     = 'activemq'
    $softwareVersion  = '5.6.0'
    $packageRelease   = '1'
    $packageTag       = "$softwareName-$softwareVersion-$packageRelease"
    $destDir          = "/usr/local/$packageTag"


    ### Package
    $require = [
        Package['openssl'],
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


    ### Symlink for compatibility with default installation directory
    file { '/opt/activemq':
	ensure  => "/usr/local/$softwareName",
	require => [
	    Package["$softwareName"],
	    File["/usr/local/$softwareName"],
	],
	backup   => false,
    }
}
