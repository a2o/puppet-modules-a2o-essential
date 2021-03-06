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



### Software package: postfix
class   a2o_essential_linux_postfix::package::postfix   inherits   a2o_essential_linux_postfix::package::base {

    # CheckURI: ftp://ftp.arnes.si/packages/postfix-release/index.html
    $softwareName     = 'postfix'
    $softwareVersion  = '2.9.6'
    $packageRelease   = '3'
    $packageTag       = "$softwareName-$softwareVersion-$packageRelease"
    $destDir          = "/usr/local/$packageTag"

    # Extenal references
    $destDir_openssl  = '/usr/local/openssl-1.0.1e-2'


    ### Package
    $require = [
	Package['cyrus-sasl'],
	Package['openssl'],
	User['postfix'],
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
