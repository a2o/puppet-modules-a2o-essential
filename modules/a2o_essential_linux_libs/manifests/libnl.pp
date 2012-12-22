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



### Software package: libnl
class   a2o_essential_linux_libs::libnl   inherits   a2o_essential_linux_libs::base {

    # CheckURI: http://www.infradead.org/~tgr/libnl/
    $softwareName     = 'libnl'
    $softwareVersion  = '3.2.13'
    $packageRelease   = '1'
    $packageTag       = "$softwareName-$softwareVersion-$packageRelease"


    ### Package
    a2o-essential-unix::compiletool::package::generic { "$packageTag": }
}
