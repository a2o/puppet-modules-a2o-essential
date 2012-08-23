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
class   a2o_essential_linux_awstats::base {
    $thisPuppetModule = 'a2o_essential_linux_awstats'

    # Where the packages will be compiled
    $compileDir       = "/var/src/tools"
}



### Software package
class   a2o_essential_linux_awstats::package   inherits   a2o_essential_linux_awstats::base {

    # Software details
    $packageName            = 'awstats'
    $packageSoftware        = 'awstats'
    $packageSoftwareVersion = '7.0'
    $packageRelease         = '1'
    $packageEnsure          = "$packageSoftwareVersion-$packageRelease"
    $packageTag             = "$packageSoftware-$packageEnsure"
    $installScriptTpl       = "install-$packageSoftware.sh"
    $installScript          = "install-$packageTag.sh"

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



### Software package
class   a2o_essential_linux_awstats::cleanup   inherits   a2o_essential_linux_awstats::base {
    $require = [
        Package['awstats'],
	File['/usr/local/awstats'],
    ]

    a2o-essential-unix::compiletool::package::remove { 'awstats-6.90-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'awstats-6.95-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'awstats-6.95-2': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'awstats-6.95-3': compileDir => $compileDir, require => $require, }
}



### Configuration files and directories
class   a2o_essential_linux_awstats::files   inherits   a2o_essential_linux_awstats::base {

    File {
        owner    => root,
        group    => root,
	require  => File['/usr/local/awstats'],
    }

    # Directories
    file { '/etc/awstats':        ensure => directory, mode => 755 }
    file { '/var/awstats':        ensure => directory, mode => 755 }
    file { '/var/awstats/data':   ensure => directory, mode => 755 }

    # Files
    file { '/etc/awstats/awstats.defaults':   mode => 644, source => "puppet:///modules/$thisPuppetModule/awstats.defaults" }
    file { '/usr/local/bin/awstats.pl':       mode => 755, source => "puppet:///modules/$thisPuppetModule/awstats.pl" }

    # Symlinks
    file { '/usr/local/bin/logresolvemerge.pl':   ensure => '/usr/local/awstats/tools/logresolvemerge.pl' }
}



### The final all-containing classes
class a2o_essential_linux_awstats {
    include 'a2o_essential_linux_awstats::package'
    include 'a2o_essential_linux_awstats::cleanup'
    include 'a2o_essential_linux_awstats::files'
}
