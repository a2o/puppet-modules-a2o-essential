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



### Software package: nrpe
class   a2o_essential_linux_nagios::package::nrpe   inherits   a2o_essential_linux_nagios::package::base {

    # CheckURI: see base.pp file for upgrading
    $softwareName        = "$softwareName_nrpe"
    $packageTag          = "$packageTag_nrpe"
    $destDir             = "$destDir_nrpe"
    $destDirSymlink      = "$destDirSymlink_nrpe"
    $destDirSymlink_dest = "$destDirSymlink_nrpe_dest"


    ### Package
    $require = [
        Package['openssl'],
        Package['nagios-plugins'],
    ]
    a2o-essential-unix::compiletool::package::generic { "$packageTag": require => $require, }


    ### Symlink
    file { "$destDirSymlink":
	ensure  => "$destDirSymlink_dest",
	require => [
	    Package["$softwareName"],
	],
	backup   => false,
    }
}
