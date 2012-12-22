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



### Software package: jre
class   a2o-essential-linux-java::jre::package   inherits   a2o-essential-linux-java::base {

    # Package / Software details
    # CheckURI: http://www.oracle.com/technetwork/java/javase/downloads/index.html
    $softwareName        = 'jre'
    $softwareVersionDist = '7u4'
    $softwareVersion     = '1.7.0_04'
    $packageRelease      = '1'
    $packageTag          = "$softwareName-$softwareVersion-$packageRelease"

    $compileDir   = '/var/src/interpreters'
    $destDir      = "/usr/local/$packageTag"
    $destDirFinal = "/usr/local/$softwareName"


    ### Package
    a2o-essential-unix::compiletool::package::generic { "$packageTag": }


    ### Symlinks
    file { "$destDirFinal":
	ensure  => "$packageTag",
	require => Package["$softwareName"],
    }


    ### Binary symlink
    file { '/usr/local/bin/java':
	ensure  => "$destDirFinal/bin/java",
	require => File["$destDirFinal"],
    }
}



### All containing class
class   a2o-essential-linux-java::jre {
    include 'a2o-essential-linux-java::jre::package'
#    include 'a2o-essential-linux-java::jre::cleanup'
}
