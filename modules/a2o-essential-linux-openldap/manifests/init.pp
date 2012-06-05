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


### Package base class
class   a2o-essential-linux-openldap::package::base   inherits   a2o-essential-linux-openldap::base {

    # CheckURI: http://www.openldap.org/software/download/

    # Where the packages will be compiled
    $compileDir = '/var/src/daemons'

    $require    = [
	Package['perl'],
    ]
}



### Software package - current
class   a2o-essential-linux-openldap::package::current   inherits   a2o-essential-linux-openldap::base {

    # External software versions
    $externalDestDir_openssl = '/usr/local/openssl-1.0.0i-1'

    # Software details
    # WARNING: If you change version here, add old version to legacy classes below
    #          if references to this version exist in other modules
    $softwareName    = 'openldap'
    $softwareVersion = '2.4.31'
    $packageRelease  = '1'
    $packageTag      = "$softwareName-$softwareVersion-$packageRelease"

    # Package
    a2o-essential-unix::compiletool::package::generic { "$packageTag":   require => $require, }

    # Symlink
    file { "/usr/local/$softwareName":
	ensure   => "$packageTag",
	require  => Package["$softwareName"],
	backup   => false,
    }
}



### Software packages - legacy
class   a2o-essential-linux-openldap::package::legacy   inherits   a2o-essential-linux-openldap::base {
#
#    # External software versions
#    $externalDestDir_openssl = '/usr/local/openssl-1.0.0i-1'
#
#    # Packages
#    a2o-essential-unix::compiletool::package::multi   { 'openldap-2.4.25-1':   require => $require, }
#    a2o-essential-unix::compiletool::package::multi   { 'openldap-2.4.28-1':   require => $require, }
}



### Software packages - legacy
class   a2o-essential-linux-openldap::package::cleanup   inherits   a2o-essential-linux-openldap::package::base {
    $require = [
        Package['openldap'],
	File['/usr/local/openldap'],
    ]

    a2o-essential-unix::compiletool::package::remove { 'openldap-2.4.23-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'openldap-2.4.23-2': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'openldap-2.4.23-3': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'openldap-2.4.23-4': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'openldap-2.4.24-1': compileDir => $compileDir, require => $require, }
#    a2o-essential-unix::compiletool::package::remove { 'openldap-2.4.25-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'openldap-2.4.26-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'openldap-2.4.28-1': compileDir => $compileDir, require => $require, }
}



### Software packages together
class   a2o-essential-linux-openldap::package {
    include 'a2o-essential-linux-openldap::package::current'
    include 'a2o-essential-linux-openldap::package::legacy'
    include 'a2o-essential-linux-openldap::package::cleanup'
#    class { 'a2o-essential-linux-openldap::package::cleanup': stage => cleanup; }
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
