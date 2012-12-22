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



### Base class
class   a2o-essential-linux-gearman::base {
    $thisPuppetModule = 'a2o-essential-linux-gearman'
}



### Software package
class   a2o-essential-linux-gearman::package   inherits   a2o-essential-linux-gearman::base {

    # Software details
    $packageName            = 'gearman'
    $packageSoftwareName    = 'gearman'
    $packageSoftwareVersion = '0.39'
    $packageRelease         = '1'
    $packageEnsure          = "$packageSoftwareVersion-$packageRelease"
    $packageTag             = "$packageSoftwareName-$packageEnsure"
    $installScriptTpl       = "install-$packageSoftwareName.sh"
    $installScript          = "install-$packageTag.sh"

    # Where the packages will be compiled
    $compileDir             = "/var/src/daemons"

    # Destination directory
    $destDir             = "/usr/local/$packageTag"
    $destDirSymlink      = "/usr/local/$packageName"
    $destDirSymlink_dest = "$packageTag"


    # Installation
    file { "$compileDir/$installScript":
        owner    => root,
        group    => root,
        mode     => 755,
	content  => template("$thisPuppetModule/$installScriptTpl"),
	require  => File["$compileDir"],
    }
    package { "$packageName":
	require  => [
	    File["$compileDir/$installScript"],
	    Package['boost'],
	    Package['libevent'],
	    Package['libgearman'],
	    Package['libmemcached'],
#	    Package['sqlite'],
	],
	provider => 'a2o_linux_compiletool',
        ensure   => "$packageEnsure",
	source   => "$compileDir/$installScript",
    }


    # Symlink
    file { "$destDirSymlink":
	ensure   => "$destDirSymlink_dest",
	require  => Package["$packageName"],
	backup   => false,
    }
}



### Users and groups
class   a2o-essential-linux-gearman::users   inherits   a2o-essential-linux-gearman::base {
    group { 'gearman': 
	ensure   => present,
	gid      => 4730,
    }

    user { 'gearman':
	require    => Group['gearman'],
	provider   => useradd,
	allowdupe  => false,
        ensure     => present,
	uid        => 4730,
	gid        => gearman,
	password   => '*',
	shell      => '/bin/bash',
	home       => '/var/gearman',
	managehome => true,
    }
}



### Files for gearman
class   a2o-essential-linux-gearman::files   inherits   a2o-essential-linux-gearman::base {

    # Template
    File {
        owner    => gearman,
        group    => gearman,
	require  => User['gearman'],
    }

    # Dirs
    file { '/var/gearman':       ensure => directory, mode => 755, }
    file { '/var/gearman/run':   ensure => directory, mode => 755, }

    # Log file
    file { '/var/log/gearmand.log':   ensure => present, group => root, mode => 644, }
}



### Final all-containing class
class a2o-essential-linux-gearman {
    include 'a2o-essential-linux-gearman::package'
    include 'a2o-essential-linux-gearman::users'
    include 'a2o-essential-linux-gearman::files'
}
