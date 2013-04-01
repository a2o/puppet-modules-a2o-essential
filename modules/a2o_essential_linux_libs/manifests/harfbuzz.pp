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



### Software package: harfbuzz
class   a2o_essential_linux_libs::harfbuzz   inherits   a2o_essential_linux_libs::base {

    # CheckURI: 
    # CheckURI: http://www.freedesktop.org/software/harfbuzz/release/
    $softwareName     = 'harfbuzz'
    $softwareVersion  = '0.9.14'
    $packageRelease   = '1'
    $packageTag       = "$softwareName-$softwareVersion-$packageRelease"


    ### Package
    $require = [
	Package['glib'],
	Package['icu'],
	Package['freetype'],
    ]
    a2o-essential-unix::compiletool::package::generic { "$packageTag": require => $require }
}
