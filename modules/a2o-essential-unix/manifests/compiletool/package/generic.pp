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



### Generic a2o compiletool package definition
#
# Template for installing packages. Creates install file from template that
# resides in module where this thingie was called from. Then executes it :)

define   a2o-essential-unix::compiletool::package::generic (
    $packageNameLong     = 0,
    $installScriptTplUri = undef,
    $compileDirPath      = undef,
    $require             = []
) {


    ###
    ### Software and package details - retrieve from define $name
    ###
    $softwareName    = regsubst($name, '^(.+)-([^-]+)-([^-]+)$', '\1')
    $softwareVersion = regsubst($name, '^(.+)-([^-]+)-([^-]+)$', '\2')
    $packageRelease  = regsubst($name, '^(.+)-([^-]+)-([^-]+)$', '\3')
    $packageEnsure   = "${softwareVersion}-${packageRelease}"
    $packageTag      = "${softwareName}-${packageEnsure}"


    # Package name selection - multipackage support is done through this
    $packageName = $packageNameLong ? {
	1       => $packageTag,
	default => $softwareName,
    }


    ###
    ### Installation script details
    ###
    if $compileDir == undef {
	if $compileDirPath == undef {
	    $compileDir = '/var/src/undefined'
	} else {
	    $compileDir = "$compileDirPath"
	}
    }
    if $installScriptTplUri == undef {
	$installScriptTplUriReal = "$thisPuppetModule/install-${softwareName}.sh"
    } else {
	$installScriptTplUriReal = "$installScriptTplUri"
    }
    $installScriptPath = "$compileDir/install-${packageTag}.sh"


    ###
    ### Destination directory
    ###
    if $destDir == undef {
	$destDir = "/usr/local/$packageTag"
    }


    ###
    ### Legacy compatibility definitions
    ###
    if $packageVersion == undef {
	$packageVersion = "$softwareVersion"
    }
    if $packageSoftwareVersion == undef {
	$packageSoftwareVersion = "$softwareVersion"
    }


    # Some debugging
#    notice "INFO: $name : name    : $softwareName"
#    notice "INFO: $name : version : $softwareVersion"
#    notice "INFO: $name : release : $packageRelease"
#    notice "INFO: $name : cdir    : $compileDir"
#    notice "INFO: $name : ddir    : $destDir"
#    notice "INFO: $name : instUri : $installScriptTplUriReal"
#    notice "INFO: $name : instFle : $installScriptPath"


    ###
    ### Installation - install file and package definition
    ###
    file { "$installScriptPath":
	content  => template("$installScriptTplUriReal"),
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
	source   => "$installScriptPath",
	require  => [
    	    File["$installScriptPath"],
	    $require,
	],
    }
}
