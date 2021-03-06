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



### Software package: mongodb
class   a2o_essential_linux_mongodb::package::mongodb   inherits   a2o_essential_linux_mongodb::package::base {

    # Package / Software details
    # CheckURI: http://www.mongodb.org/downloads
    $softwareName     = 'mongodb'
    $softwareVersion  = '2.0.5'
    $packageRelease   = '1'
    $packageTag       = "$softwareName-$softwareVersion-$packageRelease"
    $destDir          = "/usr/local/$packageTag"


    ### Package
    $require = [
        Package['boost'],
        Package['libpcap'],
        Package['pcre'],
        Package['scons'],
    ]
    a2o-essential-unix::compiletool::package::generic { "$packageTag": require => $require, }


    ### Symlinks
    file { "/usr/local/$softwareName":
        ensure  => "$packageTag",
        require => [
            Package["$softwareName"],
        ],
        backup  => false,
    }
}
