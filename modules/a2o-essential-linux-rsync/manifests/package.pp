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



### Software package: rsync
class   a2o-essential-linux-rsync::package   inherits   a2o-essential-linux-rsync::base {

    # Software details
    # CheckURI: 
    $softwareName     = 'rsync'
    $softwareVersion  = '3.0.9'
    $packageRelease   = '1'
    $packageTag       = "$softwareName-$softwareVersion-$packageRelease"

    $compileDir = '/var/src/tools'

    # Package
    a2o-essential-unix::compiletool::package::generic { "$packageTag": }

#    # Symlink
#    file { "/usr/local/$softwareName":
#        ensure   => "$packageTag",
#        require  => Package["$softwareName"],
#	backup   => false,
#    }
}
