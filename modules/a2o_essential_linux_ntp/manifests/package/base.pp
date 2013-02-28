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
class   a2o_essential_linux_ntp::package::base   inherits   a2o_essential_linux_ntp::base {

    $compileDir = '/var/src/daemons'

    # Package / Software details
    # CheckURI: http://www.ntp.org/downloads.html
    $softwareName_ntp     = 'ntp'
    $softwareVersion_ntp  = '4.2.6_p5'
    $packageRelease_ntp   = '3'
    $packageTag_ntp       = "$softwareName_ntp-$softwareVersion_ntp-$packageRelease_ntp"

    # External references
    $externalDestDir_openssl = '/usr/local/openssl-1.0.1e-2'
}
