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



### Software package: libassuan
class   a2o_essential_linux_libs::libassuan   inherits   a2o_essential_linux_libs::base {

    # CheckURI: http://www.gnupg.org/download/index.en.html#libassuan
    $softwareName     = 'libassuan'
    $softwareVersion  = '2.0.3'
    $packageRelease   = '1'
    $packageTag       = "$softwareName-$softwareVersion-$packageRelease"


    ### Package
    $require = [
    ]
    a2o-essential-unix::compiletool::package::generic { "$packageTag": require => $require }
}
