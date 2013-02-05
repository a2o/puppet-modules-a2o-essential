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
class   a2o-essential-linux-openssl::base {
    $thisPuppetModule = 'a2o-essential-linux-openssl'
}



### All packages class
class   a2o-essential-linux-openssl::packages {

    # CheckURI: http://www.openssl.org/
    #
    # Packages 0.9.8x are old and kept here for legacy reasons, but to be removed ASAP
    # Packages 1.0.0x are current
    # Packages 1.0.1x and up are new, we will start with testing them
    #
    # To add new version, just add new line below with new version
    #
    # The latest version (latest as in alphabetically) must not be defined as ::generic, but as ::latest
    # (puppet package name quirk)
    #
    # WARNING: If you add/remove packages, update symlinks below

    a2o-essential-linux-openssl::package::generic { 'openssl-0.9.8w-1': }
    a2o-essential-linux-openssl::package::generic { 'openssl-1.0.0h-1': }
    a2o-essential-linux-openssl::package::generic { 'openssl-1.0.0i-1': }
    a2o-essential-linux-openssl::package::generic { 'openssl-1.0.0k-1': }
    a2o-essential-linux-openssl::package::latest  { 'openssl-1.0.1d-1': }
}



### Remove old packages
class   a2o-essential-linux-openssl::cleanup {
    $compileDir = '/var/src/libs'
    $require    = [
	Package['openssl'],
	File['/usr/local/openssl'],
	File['/usr/local/openssl-0.9.8'],
	File['/usr/local/openssl-1.0.0'],
    ]

    a2o-essential-unix::compiletool::package::remove { 'openssl-0.9.8m-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'openssl-0.9.8n-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'openssl-0.9.8o-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'openssl-0.9.8p-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'openssl-0.9.8q-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'openssl-0.9.8r-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'openssl-0.9.8s-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'openssl-0.9.8t-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'openssl-0.9.8u-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'openssl-0.9.8v-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'openssl-1.0.0d-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'openssl-1.0.0e-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'openssl-1.0.0f-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'openssl-1.0.0g-1': compileDir => $compileDir, require => $require, }
}



### Symbolic links
class   a2o-essential-linux-openssl::symlinks {

    # WARNING:
    # WARNING: Don't change symlinks unless you know what you are doing
    # WARNING:

    ### Legacy symlink
    # Major version symlink
    file { '/usr/local/openssl-0.9.8':
	ensure   => 'openssl-0.9.8w-1',
	require  => Package['openssl-0.9.8w-1'],
	backup   => false,
    }

    ### Testing symlink
    file { '/usr/local/openssl-1.0.1':
	ensure   => 'openssl-1.0.1d-1',
	require  => Package['openssl'],
	backup   => false,
    }

    ### Current symlink
    # Major version symlink
    file { '/usr/local/openssl-1.0.0':
	ensure   => 'openssl-1.0.0k-1',
	require  => [
#	    Package['openssl-1.0.0k-1'],
	    Package['openssl'],
	],
	backup   => false,
    }
    # Final version symlink
    file { '/usr/local/openssl':
	ensure   => 'openssl-1.0.0',
	require  => File['/usr/local/openssl-1.0.0'],
	backup   => false,
    }
}



### Directories
class   a2o-essential-linux-openssl::dirs   inherits   a2o-essential-linux-openssl::base {

    File {
	ensure   => directory,
	owner    => root,
	group    => root,
	mode     => 755,
	force    => false,
	links    => follow,
    }

    file { '/etc/ssl':         }
    file { '/etc/ssl/certs':   }
}



### CA certificate files
class   a2o-essential-linux-openssl::files_ca   inherits   a2o-essential-linux-openssl::base {

    File {
	owner    => root,
	group    => root,
	mode     => 644,
    }

    file { '/etc/ssl/certs/mozilla-bundle.crt':
	ensure   => present,
	source   => "puppet:///modules/$thisPuppetModule/mozilla-bundle.crt",
    }

    # Symlinks
#    file { '/etc/ssl/certs/ca-bundle.crt':        ensure => link, target => 'mozilla-bundle.crt' }
    file { '/etc/ssl/certs/curl-ca-bundle.crt':   ensure => link, target => 'mozilla-bundle.crt' }
}



### The final all-containing classes
class   a2o-essential-linux-openssl {
    include 'a2o-essential-linux-openssl::packages'
    include 'a2o-essential-linux-openssl::symlinks'
    include 'a2o-essential-linux-openssl::dirs'
    include 'a2o-essential-linux-openssl::files_ca'
    include 'a2o-essential-linux-openssl::cleanup'
}
