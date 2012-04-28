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



### Remove package
#
# Removes installation directory, install scripts and install logs

define   a2o-essential-unix::compiletool::package::remove   ($compileDir, $require=[]) {

    # Requirement definition
    File {
        ensure  => absent,
        require => $require,
	backup  => false,
    }

    # Which install script to remove
    $installScript = "$compileDir/install-${name}.sh"

    # Remove install script and compile log and status files
    file { "$installScript":                       }
    file { "/var/log/packages_compiled/$name":     }
    file { "/var/log/packages_compiled/$name.log": }

    # Remove destination directories
    file { "/usr/local/$name":
	recurse => true,
	force   => true,
    }
}
