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



### Software package: at
class   a2o_essential_linux_at::package::at   inherits   a2o_essential_linux_at::package::base {

    # Package / Software details
    $softwareName     = "$softwareName_at"
    $softwareVersion  = "$softwareVersion_at"
    $packageRelease   = "$packageRelease_at"
    $packageTag       = "$packageTag_at"
    $destDir          = "$destDir_at"


    ### Package
    $require = [
        Package['ntp'],
    ]
    a2o-essential-unix::compiletool::package::generic { "$packageTag": require => $require, }
}
