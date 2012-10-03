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



### Software package base class
class   a2o_essential_linux_memcached::package::base   inherits   a2o_essential_linux_memcached::base {

    $compileDir = '/var/src/daemons'

    # Package / Software details
    # CheckURI: http://www.memcached.org/downloads.html
    $softwareName_memcached    = 'memcached'
    $softwareVersion_memcached = '1.4.15'
    $packageRelease_memcached  = '1'
    $packageTag_memcached      = "$softwareName_memcached-$softwareVersion_memcached-$packageRelease_memcached"
}
