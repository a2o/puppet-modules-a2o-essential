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



### Software package: subversion
class   a2o_essential_linux_subversion::package::subversion   inherits   a2o_essential_linux_subversion::package::base {

    # Package / Software details
    # CheckURI: http://subversion.apache.org/download/
    $softwareName     = 'svn'
    $softwareVersion  = '1.7.9'
    $packageRelease   = '1'
    $packageTag       = "$softwareName-$softwareVersion-$packageRelease"
    $destDir          = "/usr/local/$packageTag"


    ### Additinal versions
    $externalDestDir_openssl = '/usr/local/openssl-1.0.1e-2'


    ### Package
    $require = [
        Package['cyrus-sasl'],
        Package['openssl'],
        Package['sqlite'],
    ]
    a2o-essential-unix::compiletool::package::generic { "$packageTag": require => $require, }


    ### Symlink
    file { "/usr/local/$softwareName":
	ensure  => "$packageTag",
	require => [
	    Package["$softwareName"],
	],
	backup   => false,
    }
}
