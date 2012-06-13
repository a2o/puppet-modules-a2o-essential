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



### Software package: mk-livestatus
class   a2o_essential_linux_nagios::package::mk_livestatus   inherits   a2o_essential_linux_nagios::package::base {

    # Package / Software details
    # CheckURI: http://mathias-kettner.de/check_mk_download.html
    $softwareName     = "$packageTag_nagios-mk-livestatus"
    $softwareVersion  = '1.1.12p6'
    $packageRelease   = '1'
    $packageTag       = "$softwareName-$softwareVersion-$packageRelease"
    $destDir          = "$destDir_nagios/$packageTag"


    ### Package
    $require = [
        Package['nagios'],
    ]
    a2o-essential-unix::compiletool::package::generic { "$packageTag": require => $require, }


    ### Symlink
    file { "$destDir_nagios/$softwareName":
	ensure  => "$packageTag",
	require => [
	    Package["$softwareName"],
	],
	backup   => false,
    }
}
