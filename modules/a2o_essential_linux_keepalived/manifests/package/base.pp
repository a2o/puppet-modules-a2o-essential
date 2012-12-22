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



### Software package base class
class   a2o_essential_linux_keepalived::package::base   inherits   a2o_essential_linux_keepalived::base {

    $compileDir = '/var/src/daemons'

    # Package / Software details
    # CheckURI: http://www.keepalived.org/download.html
    $softwareName_keepalived     = 'keepalived'
    $softwareVersion_keepalived  = '1.2.7'
    $packageRelease_keepalived   = '1'
    $packageTag_keepalived       = "$softwareName_keepalived-$softwareVersion_keepalived-$packageRelease_keepalived"
    $destDir_keepalived          = "/usr/local/$packageTag_keepalived"
}
