###########################################################################
# a2o Essential Puppet Modules                                            #
#-------------------------------------------------------------------------#
# Copyright (c) 2012 Bostjan Skufca                                       #
#-------------------------------------------------------------------------#
# This source file is subject to version 2.0 of the Apache License,       #
# that is bundled with this package in the file LICENSE, and is           #
# available through the world-wide-web at the following url:              #
# http://www.apache.org/licenses/LICENSE-2.0                              #
#-------------------------------------------------------------------------#
# Authors: Bostjan Skufca <my_name [at] a2o {dot} si>                     #
###########################################################################



### Software package: postfix-pa
class   a2o_essential_linux_postfix::package::postfix_pa   inherits   a2o_essential_linux_postfix::package::base_pa {

    # CheckURI: ftp://ftp.arnes.si/packages/postfix-release/index.html
    $softwareName     = 'postfix-pa'
    $softwareVersion  = '2.9.4'
    $packageRelease   = '2'
    $packageTag       = "$softwareName-$softwareVersion-$packageRelease"
    $destDir          = "/usr/local/$packageTag"

    # VDA versions
    # CheckURI: http://vda.sourceforge.net/
    $softwareVersion_vda = 'v11-2.9.1'

    # Extenal references
    $destDir_mysql    = '/usr/local/mysql-5.1.63-1'
    $destDir_openssl  = '/usr/local/openssl-1.0.0i-1'


    ### Package
    $require = [
	Package['cyrus-sasl'],
	Package['mysql'],
	Package['openssl'],
	User['postfix'],
	Service['a2o-linux-clamav-milter'],
    ]
    a2o-essential-unix::compiletool::package::generic { "$packageTag": require => $require }


    ### Symlink
    file { "/usr/local/postfix":
	ensure  => link,
	target  => "$packageTag",
	require => [
	    Package["$softwareName"],
        ],
        backup   => false,
    }
}
