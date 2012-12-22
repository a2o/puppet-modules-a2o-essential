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



### Software package: ant
class   a2o-essential-linux-tools::ant::package   inherits   a2o-essential-linux-tools::base {

    # Package / Software details
    # CheckURI: http://ant.apache.org/
    $softwareName     = 'apache-ant'
    $softwareVersion  = '1.8.4'
    $packageRelease   = '1'
    $packageTag       = "$softwareName-$softwareVersion-$packageRelease"

    $compileDir = '/var/src/tools'
    $destDir    = "/usr/local/$packageTag"


    ### Additinal versions
    # CheckURI: http://code.google.com/p/dbdeploy/downloads/list
    $softwareVersion_dbDeploy = '3.0M3'
    # CheckURI: http://dev.mysql.com/downloads/connector/j/
    $softwareVersion_myConnJ  = '5.1.21'


    ### Package
    $require = [
        Package['jdk'],
    ]
    a2o-essential-unix::compiletool::package::generic { "$packageTag": require => $require, }


    ### Symlinks
    file { "/usr/local/$softwareName":
	ensure  => "$packageTag",
	require => Package["$softwareName"],
    }
    file { "/usr/local/ant":
	ensure  => "$softwareName",
	require => File["/usr/local/$softwareName"],
    }


    ### Binaries
    file { '/usr/local/bin/ant':
	ensure  => present,
	owner   => root,
	group   => root,
	mode    => 755,
	source  => "puppet:///modules/$thisPuppetModule/ant/ant",
	require => File['/usr/local/ant'],
    }
    file { '/usr/local/bin/dbdeploy':
	ensure  => present,
	owner   => root,
	group   => root,
	mode    => 755,
	source  => "puppet:///modules/$thisPuppetModule/ant/dbdeploy",
	require => File['/usr/local/ant'],
    }
}



### Remove old packages
class   a2o-essential-linux-tools::ant::cleanup {
    $compileDir = '/var/src/tools'
    $require    = [
	Package['apache-ant'],
	File['/usr/local/apache-ant'],
	File['/usr/local/ant'],
    ]

    a2o-essential-unix::compiletool::package::remove { 'apache-ant-1.8.3-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'apache-ant-1.8.3-2': compileDir => $compileDir, require => $require, }
#    a2o-essential-unix::compiletool::package::remove { 'apache-ant-1.8.3-3': compileDir => $compileDir, require => $require, }
}



### All containing class
class   a2o-essential-linux-tools::ant {
    include 'a2o-essential-linux-tools::ant::package'
    include 'a2o-essential-linux-tools::ant::cleanup'
}
