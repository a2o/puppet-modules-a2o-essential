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



### Software package: lftp
class   a2o_essential_linux_tools::lftp   inherits   a2o_essential_linux_tools::base {

    # CheckURI: http://lftp.yar.ru/get.html
    # CheckURI: ftp://ftp.tuwien.ac.at/infosys/browsers/ftp/lftp/
    $softwareName     = 'lftp'
    $softwareVersion  = '4.4.5'
    $packageRelease   = '1'
    $packageTag       = "$softwareName-$softwareVersion-$packageRelease"


    ### Package
    $require = [
	Package['gnutls'],
	Package['libunwind'],
    ]
    a2o-essential-unix::compiletool::package::generic { "$packageTag":
	require => $require,
    }
}
