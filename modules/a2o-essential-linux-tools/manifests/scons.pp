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



### Software package: scons
class   a2o-essential-linux-tools::scons::package   inherits   a2o-essential-linux-tools::base {

    # Package / Software details
    # CheckURI: http://www.scons.org/
    $softwareName     = 'scons'
    $softwareVersion  = '2.1.0'
    $packageRelease   = '1'
    $packageTag       = "$softwareName-$softwareVersion-$packageRelease"
    $destDir          = "/usr/local/$packageTag"


    ### Package
    $require = [
        Package['boost'],
        Package['python'],
    ]
    a2o-essential-unix::compiletool::package::generic { "$packageTag": require => $require, }


    ### Symlinks
    file { "/usr/local/$softwareName":
	ensure  => "$packageTag",
	require => Package["$softwareName"],
    }


    ### Binaries
    file { '/usr/local/bin/scons':
	ensure  => '/usr/local/scons/bin/scons',
	require => File['/usr/local/scons'],
    }
}



### Remove old packages
class   a2o-essential-linux-tools::scons::cleanup   inherits   a2o-essential-linux-tools::base {

    $require    = [
	Package['scons'],
	File['/usr/local/scons'],
    ]

    a2o-essential-unix::compiletool::package::remove { 'scons-2.1.0-0': compileDir => $compileDir, require => $require, }
}



### All containing class
class   a2o-essential-linux-tools::scons {
    include 'a2o-essential-linux-tools::scons::package'
    include 'a2o-essential-linux-tools::scons::cleanup'
}
