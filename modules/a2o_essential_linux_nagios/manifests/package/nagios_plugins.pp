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



### Software package: nagios-plugins
class   a2o_essential_linux_nagios::package::nagios_plugins   inherits   a2o_essential_linux_nagios::package::base {

    # CheckURI: see base.pp file for upgrading
    $softwareName        = "$softwareName_plugins"
    $packageTag          = "$packageTag_plugins"
    $destDir             = "$destDir_plugins"
    $destDirSymlink      = "$destDirSymlink_plugins"
    $destDirSymlink_dest = "$destDirSymlink_plugins_dest"


    ### Package
    $require = [
        Package['perl'],
        Package['openssl'],
        Package['openldap'],
        Package['mysql'],
    ]
    a2o-essential-unix::compiletool::package::generic { "$packageTag": require => $require, }


    ### Additional check scripts
    File {
	owner   => root,
	group   => root,
	mode    => 755,
	require => Package["$softwareName"],
	before  => File["$destDirSymlink"],
    }
    file { "$destDir/libexec/check_dns_host":           source  => "puppet:///modules/$thisPuppetModule/check_dns_host"         }
    file { "$destDir/libexec/check_dns_host_reverse":   source  => "puppet:///modules/$thisPuppetModule/check_dns_host_reverse" }


    ### Symlink
    file { "$destDirSymlink":
        ensure  => "$destDirSymlink_dest",
	require => [
	    Package["$softwareName"],
	],
	before   => undef,
	backup   => false,
    }
}
