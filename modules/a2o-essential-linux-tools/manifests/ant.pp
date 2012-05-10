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



### Software package: ant
class   a2o-essential-linux-tools::ant::package   inherits   a2o-essential-linux-tools::base {

    # Package / Software details
    # CheckURI: http://ant.apache.org/
    $softwareName     = 'apache-ant'
    $softwareVersion  = '1.8.3'
    $packageRelease   = '1'
    $packageTag       = "$softwareName-$softwareVersion-$packageRelease"

    $compileDir = '/var/src/tools'
    $destDir    = "/usr/local/$packageTag"


    ### Package
    $require = [
        Package['jdk'],
    ]
    a2o-essential-unix::compiletool::package::generic { "$packageTag": require => $require, }


    ### Symlinks
    file { "/usr/local/$softwareName":
	ensure  => "$packageTag",
	require => Package["$softwareName"],
    }
    file { "/usr/local/ant":
	ensure  => "$softwareName",
	require => File["/usr/local/$softwareName"],
    }


    ### Binary
    file { "/usr/local/bin/ant":
	ensure  => present,
	owner   => root,
	group   => root,
	mode    => 755,
	source  => "puppet:///modules/$thisPuppetModule/ant/ant",
	require => File['/usr/local/ant'],
    }
}



### All containing class
class   a2o-essential-linux-tools::ant {
    include 'a2o-essential-linux-tools::ant::package'
#    include 'a2o-essential-linux-tools::ant::cleanup'
}
