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



### Software package: memcached
class   a2o_essential_linux_memcached::package::memcached   inherits   a2o_essential_linux_memcached::package::base {

    # Package / Software details
    # CheckURI: http://memcached.org/
    $softwareName    = "$softwareName_memcached"
    $softwareVersion = "$softwareVersion_memcached"
    $packageRelease  = "$packageRelease_memcached"
    $packageTag      = "$packageTag_memcached"
#    $destDir         = "$destDir_memcached"


    ### Package
    $require = [
        Package['libevent'],
        Package['perl'],
    ]
    a2o-essential-unix::compiletool::package::generic { "$packageTag": require => $require }


#    ### Symlink
#    file { "/usr/local/$softwareName":
#	ensure  => "$packageTag",
#	require => [
#    	    Package["$softwareName"],
#	],
#        backup   => false,
#    }
}
