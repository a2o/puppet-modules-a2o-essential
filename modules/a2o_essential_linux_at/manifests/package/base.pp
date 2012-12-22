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
class   a2o_essential_linux_at::package::base   inherits   a2o_essential_linux_at::base {

    $compileDir = '/var/src/daemons'

    # Package / Software details
    # CheckURI: ftp://ftp.debian.org/debian/pool/main/a/at
    $softwareName_at     = 'at'
    $softwareVersion_at  = '3.1.13'
    $packageRelease_at   = '1'
    $packageTag_at       = "$softwareName_at-$softwareVersion_at-$packageRelease_at"
}
