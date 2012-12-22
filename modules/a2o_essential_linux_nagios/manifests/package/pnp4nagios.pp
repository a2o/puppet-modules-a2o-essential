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



### Software package: pnp4nagios
class   a2o_essential_linux_nagios::package::pnp4nagios   inherits   a2o_essential_linux_nagios::package::base {

    # CheckURI: see base.pp file for upgrading
    $softwareName        = "$softwareName_pnp4nagios"
    $packageTag          = "$packageTag_pnp4nagios"
    $destDir             = "$destDir_pnp4nagios"
    $destDirSymlink      = "$destDirSymlink_pnp4nagios"
    $destDirSymlink_dest = "$destDirSymlink_pnp4nagios_dest"


    ### Package
    $require = [
        Package['nagios'],
        Package['rrdtool'],
    ]
    a2o-essential-unix::compiletool::package::generic { "$packageTag":
	require => $require,
	installScriptTplUri => "$thisPuppetModule/install-pnp4nagios.sh",
    }


    ### Symlink
    file { "$destDirSymlink":
	ensure  => "$destDirSymlink_dest",
	require => [
	    Package["$softwareName"],
	],
	backup   => false,
    }
}
