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



### Software package: collectd
class   a2o_essential_linux_collectd::package::collectd   inherits   a2o_essential_linux_collectd::package::base {

    # Package / Software details
    $softwareName    = "$softwareName_collectd"
    $softwareVersion = "$softwareVersion_collectd"
    $packageRelease  = "$packageRelease_collectd"
    $packageTag      = "$packageTag_collectd"
    $destDir         = "$destDir_collectd"


    ### Package
    $require = [
        Package['openssl'],
        Package['mysql'],
        Package['rrdtool'],
#        Package['liboping'],
    ]
    a2o-essential-unix::compiletool::package::generic { "$packageTag": require => $require }


    ### Symlink
    file { "/usr/local/$softwareName":
	ensure  => "$packageTag",
	require => [
    	    Package["$softwareName"],
	],
        backup   => false,
    }
}
