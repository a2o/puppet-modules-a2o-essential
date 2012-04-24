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



### Generic OpenSSL package definition

define   a2o-essential-linux-openssl::package::generic   ($packageNameShort=0) {

    # WARNING
    # Latest version must have "packageName" as id, others "packageTag"
    # All compat must have before => Package['openssl']
    # Otherwise it just starts recompiling package over and over again

    # Software details
    $softwareName         = 'openssl'
    $softwareVersionMajor = regsubst($name, '^openssl-([0-9\.]+)([a-z]?)-(.+)$', '\1')
    $softwareVersion      = regsubst($name, '^openssl-([0-9\.]+[a-z]?)-(.+)$', '\1')

    # Package details
    $packageRelease       = regsubst($name, '^openssl-[^-]+-(.+)$', '\1')
    $packageEnsure        = "${softwareVersion}-${packageRelease}"
    $packageTag           = "${softwareName}-${packageEnsure}"

    # Package name selection
    $packageName = $packageNameShort ? {
	1       => $softwareName,
	default => $packageTag,
    }

    # Install script details
    $installScriptTpl     = "install-${softwareName}-$softwareVersionMajor.sh"
    $installScript        = "install-${packageTag}.sh"
    $compileDir           = "/var/src/libs"

    # Installation destination directory
    $destDir              = "/usr/local/$packageTag"

    # Workaround
    $thisPuppetModule = 'a2o-essential-linux-openssl'


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
#	before   => Package["$Name"],
    }
}
