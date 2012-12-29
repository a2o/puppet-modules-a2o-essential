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



### Software package base class
class   a2o_essential_linux_openssh_sys::package::base   inherits   a2o_essential_linux_openssh_sys::base {

    $compileDir = '/var/src/daemons'

    # Package / Software details
    # CheckURI: http://www.openssh.org
    $softwareName_openssh     = 'openssh-sys'
    $softwareVersion_openssh  = '6.1p1'
    $packageRelease_openssh   = '2'
    $packageTag_openssh       = "$softwareName_openssh-$softwareVersion_openssh-$packageRelease_openssh"
    $destDir_openssh          = "/usr/local/$packageTag_openssh"


    ### External destdirs
    # Defined in ../base.php


    # Package / Software details
    # CheckURI: http://www.zlib.org
    # WARNING: Only bump this version/release if you also recompile openssh.
    # WARNING: Otherwise you can lock yourself out of machine.
    $softwareName_zlib     = "$packageTag_openssh-zlib"
    $softwareVersion_zlib  = '1.2.7'
    $packageRelease_zlib   = '1'
    $packageTag_zlib       = "$softwareName_zlib-$softwareVersion_zlib-$packageRelease_zlib"
}
