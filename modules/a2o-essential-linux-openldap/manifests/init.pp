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



### Base class
class   a2o-essential-linux-openldap::base {
    $thisPuppetModule = 'a2o-essential-linux-openldap'
}



### Software package
class   a2o-essential-linux-openldap::package   inherits   a2o-essential-linux-openldap::base {

    # Software details
    $packageName            = 'openldap'
    $packageSoftware        = 'openldap'
    # CheckURI: http://www.openldap.org/software/download/
    $packageSoftwareVersion = '2.4.31'
    $packageRelease         = '1'
    $packageEnsure          = "$packageSoftwareVersion-$packageRelease"
    $packageTag             = "$packageSoftware-$packageEnsure"
    $installScriptTpl       = "install-$packageSoftware.sh"
    $installScript          = "install-$packageTag.sh"

    # External software versions
    $externalDestDir_openssl = '/usr/local/openssl-1.0.0i-1'

    # Where the packages will be compiled
    $compileDir             = "/var/src/tools"

    # Global destination directory
    $destDir                = "/usr/local/$packageTag"
    $destDirSymlink         = "/usr/local/$packageSoftware"
    $destDirSymlink_dest    = "$packageTag"


    # Installation
    file { "$compileDir/$installScript":
	content  => template("$thisPuppetModule/$installScriptTpl"),
        owner    => root,
        group    => root,
        mode     => 755,
	require  => File['/var/src/build_functions.sh'],
    }
    package { "$packageName":
	provider => 'a2o_linux_compiletool',
        ensure   => "$packageEnsure",
	source   => "$compileDir/$installScript",
	require  => [
	    File["$compileDir/$installScript"],
	    Package['perl'],
	],
    }


    # Symlink
    file { "$destDirSymlink":
	ensure   => "$destDirSymlink_dest",
	require  => Package["$packageName"],
	backup   => false,
    }
}



### Configuration files and directories
class   a2o-essential-linux-openldap::files   inherits   a2o-essential-linux-openldap::base {

    file { "/etc/openldap":
	ensure   => directory,
        owner    => root,
        group    => root,
        mode     => 755,
    }
}



### The final all-containing classes
class a2o-essential-linux-openldap {
    include 'a2o-essential-linux-openldap::package'
    include 'a2o-essential-linux-openldap::files'
}
