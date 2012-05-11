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



### Software package: mongodb
class   a2o-essential-linux-mongodb::package::scons   inherits   a2o-essential-linux-mongodb::base {

    # Package / Software details
    # CheckURI: http://www.mongodb.org/downloads
    $softwareName    = 'mongodb'
    $softwareVersion = '2.0.5'
    $packageRelease  = '1'
    $packageTag      = "$softwareName-$softwareVersion-$packageRelease"

    $destDir         = "/usr/local/$packageTag"
    $destDirFinal    = "/usr/local/$softwareName"


    ### Package
    a2o-essential-unix::compiletool::package::generic { "$packageTag":
	require => [
	    Package['boost'],
	    Package['libpcap'],
	    Package['pcre'],
	    Package['scons'],
	],
    }


    ### Symlinks
    file { "$destDirFinal":
	ensure  => "$packageTag",
	require => Package["$softwareName"],
    }
}



### Remove old packages
class   a2o-essential-linux-mongodb::package::cleanup   inherits   a2o-essential-linux-mongodb::base {

    $require = [
	Package['mongodb'],
	File['/usr/local/mongodb'],
    ]

    a2o-essential-unix::compiletool::package::remove { 'mongodb-2.0.5-0': compileDir => $compileDir, require => $require, }
}


### All-containing package class
class   a2o-essential-linux-mongodb::package {
    include 'a2o-essential-linux-mongodb::package::scons'
    include 'a2o-essential-linux-mongodb::package::cleanup'
}
