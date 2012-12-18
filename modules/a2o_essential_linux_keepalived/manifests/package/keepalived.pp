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



### Software package: keepalived
class   a2o_essential_linux_keepalived::package::keepalived   inherits   a2o_essential_linux_keepalived::package::base {

    # Package / Software details
    $softwareName     = "$softwareName_keepalived"
    $softwareVersion  = "$softwareVersion_keepalived"
    $packageRelease   = "$packageRelease_keepalived"
    $packageTag       = "$packageTag_keepalived"
    $destDir          = "$destDir_keepalived"


    ### Package
    $require = [
        Package['openssl'],
    ]
    a2o-essential-unix::compiletool::package::generic { "$packageTag": require => $require, }
}
