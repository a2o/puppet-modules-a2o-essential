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



### Software package: libvirt
class   a2o_essential_linux_kvm::package::libvirt   inherits   a2o_essential_linux_kvm::package::base {

    # CheckURI: http://libvirt.org/sources/
    $softwareName     = 'libvirt'
    $softwareVersion  = '0.10.2'
    $packageRelease   = '1'
    $packageTag       = "$softwareName-$softwareVersion-$packageRelease"
    $destDir          = "/usr/local/$packageTag"


    ### Package
    $require = [
	Package['dnsmasq'],
	Package['gnutls'],
	Package['libcap-ng'],
	Package['libgcrypt'],
	Package['libnl'],
#	Package['python'],
	Package['yajl'],
    ]
    a2o-essential-unix::compiletool::package::generic { "$packageTag": require => $require }


    ### Symlink
    file { "/usr/local/$softwareName":
	ensure  => "$packageTag",
	require => [
	    Package["$softwareName"],
        ],
        backup   => false,
    }
}
