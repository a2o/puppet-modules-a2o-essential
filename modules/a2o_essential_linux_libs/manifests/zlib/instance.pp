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



### Software package instance: zlib
define   a2o_essential_linux_libs::zlib::instance (
    $packageName     = 'zlib',
    $softwareVersion = '1.2.6',
    $packageRelease  = '1',
    $destDir         = '/usr/local'
) {

    # Software details
#    $packageName      = defined in parameters above
#    $softwareVersion  = defined above
#    $packageRelease   = defined above
#    $destDir          = defined above

    $packageSoftware        = 'zlib'
    $compileDir             = '/var/src/libs'
    $thisPuppetModule       = 'a2o_essential_linux_libs'

    $packageEnsure          = "$softwareVersion-$packageRelease"
    $packageTag             = "$packageName-$packageEnsure"
    $installScriptTpl       = "install-$packageSoftware.sh"
    $installScript          = "install-$packageTag.sh"


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
	],
    }
}
