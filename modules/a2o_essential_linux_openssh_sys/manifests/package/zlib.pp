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



### Software package: zlib for openssh-sys
class   a2o_essential_linux_openssh_sys::package::zlib   inherits   a2o_essential_linux_openssh_sys::package::base {

    # Package / Software details
    # CheckURI: http://www.zlib.org
    # WARNING: Only bump this version/release if you also recompile openssh,
    # WARNING: Otherwise you can lock yourself out of machine.
    $softwareName     = "$softwareName_zlib"
    $softwareVersion  = "$softwareVersion_zlib"
    $packageRelease   = "$packageRelease_zlib"
    $packageTag       = "$packageTag_zlib"
    $destDir          = "$destDir_openssh"


    ### Package
    a2o_essential_linux_libs::zlib::instance { "$packageTag":
	packageName     => $softwareName,
	softwareVersion => $packageVersion,
	packageRelease  => $packageRelease,
	destDir         => $destDir_openssh
    }
}
