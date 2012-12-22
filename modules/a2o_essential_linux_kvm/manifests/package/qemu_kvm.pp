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



### Software package: qemu-kvm
class   a2o_essential_linux_kvm::package::qemu_kvm   inherits   a2o_essential_linux_kvm::package::base {

    # CheckURI: http://wiki.qemu.org/KVM   # Check if 1.2 is out of beta before upgrading
    # CheckURI: http://sourceforge.net/projects/kvm/files/qemu-kvm/
    $softwareName     = 'qemu-kvm'
    $softwareVersion  = '1.1.2'
    $packageRelease   = '1'
    $packageTag       = "$softwareName-$softwareVersion-$packageRelease"
    $destDir          = "/usr/local/$packageTag"


    ### Package
    $require = [
	Package['curl'],
	Package['cyrus-sasl'],
	Package['glib'],
	Package['gnutls'],
	Package['libiconv'],
	Package['python'],
	Package['sdl'],
	Package['zlib'],
    ]
    a2o-essential-unix::compiletool::package::generic { "$packageTag": require => $require }


    ### Symlinks
    file { "/usr/local/$softwareName":
        ensure  => link,
        target  => "$packageTag",
	require => [
	    Package["$softwareName"],
	],
        backup   => false,
    }
    file { '/usr/local/kvm':
        ensure  => link,
	target  => "$softwareName",
	require => [
	    File["/usr/local/$softwareName"],
	],
        backup   => false,
    }
}
