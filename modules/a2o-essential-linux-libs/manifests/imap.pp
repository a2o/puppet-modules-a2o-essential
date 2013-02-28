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



### Software package: imap
class   a2o-essential-linux-libs::imap::package   inherits   a2o-essential-linux-libs::base {

    # Software details
    $packageName            = 'imap'
    $packageSoftware        = 'imap'
    $packageSoftwareVersion = '2007f'
    $packageRelease         = '2'
    $packageEnsure          = "$packageSoftwareVersion-$packageRelease"
    $packageTag             = "$packageSoftware-$packageEnsure"
    $installScriptTpl       = "install-$packageSoftware.sh"
    $installScript          = "install-$packageTag.sh"

    # Destination directory
    $destDir                = "/usr/local/$packageTag"

    # External packages
    $externalDestDir_openssl = '/usr/local/openssl-1.0.1e-2'


    # Installation
    file { "$compileDir/$installScript":
	content  => template("$thisPuppetModule/$installScriptTpl"),
        owner    => root,
        group    => root,
        mode     => 755,
	require  => [
	    File['/var/src/build_functions.sh'],
	],
    }
    package { "$packageName":
	provider => 'a2o_linux_compiletool',
        ensure   => "$packageEnsure",
	source   => "$compileDir/$installScript",
	require  => [
	    File["$compileDir/$installScript"],
	    Package['openssl'],
	],
    }
}



### Cleanup
class   a2o-essential-linux-libs::imap::cleanup   inherits   a2o-essential-linux-libs::base {

    File {
        ensure  => absent,
        backup  => false,
	recurse => true,
	force   => true,
    }
    file {'/usr/local/imap-2007e': }
    file {'/usr/local/imap-2007f': }
}



### Package and cleanup
class   a2o-essential-linux-libs::imap   inherits   a2o-essential-linux-libs::base {
    include 'a2o-essential-linux-libs::imap::package'
    include 'a2o-essential-linux-libs::imap::cleanup'
}
