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



### Software package: git
class   a2o-essential-linux-tools::git::package   inherits   a2o-essential-linux-tools::base {

    # Software details
    $packageName            = 'git'
    $packageSoftware        = 'git'
    # CheckURI: http://www.git-scm.org/
    $packageSoftwareVersion = '1.8.1.3'
    $packageRelease         = '1'
    $packageEnsure          = "$packageSoftwareVersion-$packageRelease"
    $packageTag             = "$packageSoftware-$packageEnsure"
    $installScriptTpl       = "install-$packageSoftware.sh"
    $installScript          = "install-$packageTag.sh"

    # External software versions
    $externalDestDir_openssl = '/usr/local/openssl-1.0.1e-2'

    # Global destination directory
    $destDir             = "/usr/local/$packageTag"
    $destDirSymlink      = "/usr/local/$packageName"
    $destDirSymlink_dest = "$packageTag"


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
	    Package['python'],
	    Package['libiconv'],
	],
    }


    # Symlink
    file { "$destDirSymlink":
        ensure   => "$destDirSymlink_dest",
	require  => Package["$packageName"],
	backup   => false,
    }
}



### Cleanup - remove old versions
class   a2o-essential-linux-tools::git::cleanup   inherits   a2o-essential-linux-tools::base {
    $require = [
	Package['git'],
	File['/usr/local/git'],
    ]

    a2o-essential-unix::compiletool::package::remove { 'git-1.7.7.1-1':  compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'git-1.7.9.1-1':  compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'git-1.7.9.6-1':  compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'git-1.7.10-1':   compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'git-1.7.10.2-1': compileDir => $compileDir, require => $require, }
}



### Software package: git
class   a2o-essential-linux-tools::git   inherits   a2o-essential-linux-tools::base {
    include 'a2o-essential-linux-tools::git::package'
    include 'a2o-essential-linux-tools::git::cleanup'
}



### Symlinks
class   a2o-essential-linux-tools::git::symlinks   inherits   a2o-essential-linux-tools::base {

    # Template
    File {
	require => File['/usr/local/git'],
    }

    # Program symlinks
    file { "/usr/bin/git":                ensure  => "/usr/local/git/bin/git",                }
    file { "/usr/bin/git-receive-pack":   ensure  => "/usr/local/git/bin/git-receive-pack",   }
    file { "/usr/bin/git-shell":          ensure  => "/usr/local/git/bin/git-shell",          }
    file { "/usr/bin/git-upload-archive": ensure  => "/usr/local/git/bin/git-upload-archive", }
    file { "/usr/bin/git-upload-pack":    ensure  => "/usr/local/git/bin/git-upload-pack",    }
}



### Files
class   a2o-essential-linux-tools::git::files   inherits   a2o-essential-linux-tools::base {

    File {
	owner   => root,
	group   => root,
	mode    => 644,
	require => File['/usr/local/git'],
    }

    file { "/etc/bash_completion.d/git":   source => "puppet:///modules/$thisPuppetModule/git/bash_completion.d/git" }
}



### All
class   a2o-essential-linux-tools::git::all   inherits   a2o-essential-linux-tools::base {
    include 'a2o-essential-linux-tools::git::package'
    include 'a2o-essential-linux-tools::git::cleanup'
    include 'a2o-essential-linux-tools::git::symlinks'
    include 'a2o-essential-linux-tools::git::files'
}
