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



### Software package: pnp4nagios
class   a2o_essential_linux_nagios::package::pnp4nagios   inherits   a2o_essential_linux_nagios::package::base {

    # Package / Software details
    # CheckURI: http://sourceforge.net/projects/pnp4nagios/
    $softwareName     = "$packageTag_nagios-pnp4nagios"
    $softwareVersion  = '0.6.16'
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
