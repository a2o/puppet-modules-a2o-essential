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



### Software package: jdk
class   a2o-essential-linux-java::jdk::package   inherits   a2o-essential-linux-java::base {

    #
    # WARNING: Manual download to source.a2o.si required.
    # WARNING: Therefore unless you don't update there, don't update here!
    #

    # Package / Software details
    # CheckURI: http://www.oracle.com/technetwork/java/javase/downloads/index.html
    $softwareName        = 'jdk'
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


#    ### Binary symlink - THINK should this be here?
#    file { '/usr/local/bin/javac':
#	ensure  => "$destDirFinal/bin/javac",
#	require => File["$destDirFinal"],
#    }
}



### All containing class
class   a2o-essential-linux-java::jdk {
    include 'a2o-essential-linux-java::jdk::package'
#    include 'a2o-essential-linux-java::jdk::cleanup'
}
