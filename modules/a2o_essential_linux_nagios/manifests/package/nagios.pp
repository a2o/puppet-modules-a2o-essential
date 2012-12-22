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



### Software package: nagios
class   a2o_essential_linux_nagios::package::nagios   inherits   a2o_essential_linux_nagios::package::base {

    # CheckURI: see base.pp file for upgrading
    $softwareName        = "$softwareName_nagios"
    $packageTag          = "$packageTag_nagios"
    $destDir             = "$destDir_nagios"
    $destDirSymlink      = "$destDirSymlink_nagios"
    $destDirSymlink_dest = "$destDirSymlink_nagios_dest"


    ### Package
    $require = [
        Package['perl'],
        Package['openssl'],
        User['nagios'],
        User['nagcmd'],
    ]
    a2o-essential-unix::compiletool::package::generic { "$packageTag": require => $require, }


    ### Symlink
    file { "$destDirSymlink":
	ensure  => "$destDirSymlink_dest",
	require => [
	    Package["$softwareName"],
	    Package["$softwareName_plugins"],
	    Package["$softwareName_pnp4nagios"],
	    Package["$softwareName_mk_livestatus"],
	],
	backup   => false,
    }
}
