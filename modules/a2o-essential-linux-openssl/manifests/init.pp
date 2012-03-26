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
class   a2o-essential-linux-openssl::base {
    $thisPuppetModule = 'a2o-essential-linux-openssl'
}



### Software package: current
class   a2o-essential-linux-openssl::package::current   inherits   a2o-essential-linux-openssl::base {

    # Software details
    $packageName      = 'openssl'
    $packageSoftware  = 'openssl'

    # WARNING
    # Latest version must have "packageName" as id, others "packageTag"
    # All compat must have before => Package['openssl']
    # Otherwise it just starts recompiling package over and over again

    # (check legacy compatibility versions below)
    # CheckURI: http://openssl.org/
    $packageVersionMajor = '0.9.8'
    $packageVersionMinor = 'u'
    $packageVersion      = "$packageVersionMajor$packageVersionMinor"

    $packageRelease   = '1'
    $packageEnsure    = "${packageVersion}-${packageRelease}"
    $packageTag       = "${packageSoftware}-${packageEnsure}"
    $installScriptTpl = "install-${packageSoftware}-0.9.8.sh"
    $installScript    = "install-${packageTag}.sh"

    # Where the packages will be compiled
    $compileDir = "/var/src/libs"

    # Installation destination directory
    $destDir                  = "/usr/local/$packageTag"

    # Destination directory symlink - major version
    $destDirSymlinkMajor      = "/usr/local/openssl-$packageVersionMajor"
    $destDirSymlinkMajor_dest = "$packageTag"



    # Installation
    file { "$compileDir/$installScript":
	content  => template("$thisPuppetModule/$installScriptTpl"),
        owner    => root,
        group    => root,
        mode     => 755,
	require  => [
	    File['/var/src/build_functions.sh']
	],
    }
    package { "$packageTag":
	provider => 'a2o_linux_compiletool',
        ensure   => "$packageEnsure",
	source   => "$compileDir/$installScript",
	require  => [
	    File["$compileDir/$installScript"],
	],
	before   => Package["$packageName"],
    }


    # Major version symlink
    file { "$destDirSymlinkMajor":
	ensure   => "$destDirSymlinkMajor_dest",
	require  => Package["$packageName"],
	backup   => false,
    }
}



### Software package: compat-1
class   a2o-essential-linux-openssl::package::compat-1   inherits   a2o-essential-linux-openssl::base {

    # Software details
    $packageName      = 'openssl'
    $packageSoftware  = 'openssl'

    # CheckURI: http://openssl.org/
    $packageVersionMajor = '1.0.0'
    $packageVersionMinor = 'h'
    $packageVersion      = "${packageVersionMajor}${packageVersionMinor}"

    $packageRelease   = '1'
    $packageEnsure    = "${packageVersion}-${packageRelease}"
    $packageTag       = "${packageSoftware}-${packageEnsure}"
    $installScriptTpl = "install-${packageSoftware}-1.0.0.sh"
    $installScript    = "install-${packageTag}.sh"

    # Where the packages will be compiled
    $compileDir = "/var/src/libs"

    # Global destination directory
    $destDir             = "/usr/local/$packageTag"

    # Destination directory symlink - major version
    $destDirSymlinkMajor      = "/usr/local/openssl-$packageVersionMajor"
    $destDirSymlinkMajor_dest = "$packageTag"

    # Global destination directory
    $destDirSymlink      = "/usr/local/openssl"
    $destDirSymlink_dest = "openssl-$packageVersionMajor"


    # Installation
    file { "$compileDir/$installScript":
	content  => template("$thisPuppetModule/$installScriptTpl"),
        owner    => root,
        group    => root,
        mode     => 755,
	require  => [
	    File['/var/src/build_functions.sh']
	],
    }
    package { "$packageName":
	provider => 'a2o_linux_compiletool',
        ensure   => "$packageEnsure",
	source   => "$compileDir/$installScript",
	require  => [
	    File["$compileDir/$installScript"],
	],
    }


    # Major version symlink
    file { "$destDirSymlinkMajor":
	ensure   => "$destDirSymlinkMajor_dest",
	require  => Package["$packageName"],
	backup   => false,
    }

    # Final version symlink
    file { "$destDirSymlink":
	ensure   => "openssl-$packageVersionMajor",
	require  => File["$destDirSymlinkMajor"],
	backup   => false,
    }
}



### The final all-containing classes
class   a2o-essential-linux-openssl {
    include 'a2o-essential-linux-openssl::package::current'
    include 'a2o-essential-linux-openssl::package::compat-1'
}
