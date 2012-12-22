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



### Software package: yajl
class   a2o_essential_linux_libs::yajl   inherits   a2o_essential_linux_libs::base {

    # CheckURI: http://lloyd.github.com/yajl/
    # WARNING: Download it manually to source.a2o.si
    $softwareName     = 'yajl'
    $softwareVersion  = '2.0.1'
    $packageRelease   = '1'
    $packageTag       = "$softwareName-$softwareVersion-$packageRelease"


    ### Package
    $require = [
	Package['cmake']
    ]
    a2o-essential-unix::compiletool::package::generic { "$packageTag": require => $require }
}
