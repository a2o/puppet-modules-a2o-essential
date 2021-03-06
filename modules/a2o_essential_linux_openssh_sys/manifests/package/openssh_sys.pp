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



### Software package: openssh-sys
class   a2o_essential_linux_openssh_sys::package::openssh_sys   inherits   a2o_essential_linux_openssh_sys::package::base {

    # Package / Software details
    # CheckURI: http://www.openssh.org
    $softwareName     = "$softwareName_openssh"
    $softwareVersion  = "$softwareVersion_openssh"
    $packageRelease   = "$packageRelease_openssh"
    $packageTag       = "$packageTag_openssh"
    $destDir          = "$destDir_openssh"


    ### Package
    $require = [
        Package['openssl'],
        Package["$packageTag-zlib"],
    ]
    a2o-essential-unix::compiletool::package::generic { "$packageTag": require => $require, }


    ### Symlinks
    file { "/usr/local/$softwareName":
	ensure  => "$packageTag",
	require => [
	    Package["$softwareName"],
	],
	backup  => false,
    }
    file { '/usr/local/ssh-sys':
	ensure  => 'openssh-sys',
	require => [
	    Package["$softwareName"],
	    File["/usr/local/$softwareName"],
	],
	backup  => false,
    }
}
