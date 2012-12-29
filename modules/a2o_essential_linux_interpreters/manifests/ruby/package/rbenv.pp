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



### Software package: rbenv
class   a2o_essential_linux_interpreters::ruby::package::rbenv   inherits   a2o_essential_linux_interpreters::ruby::base {

    # Package / Software details
    $softwareName     = 'rbenv'
    $softwareVersion  = '0.1.0'
    $packageRelease   = '1'
    $packageTag       = "$softwareName-$softwareVersion-$packageRelease"
    $destDir          = "/usr/local/$packageTag"

    ### rbenv and ruby-build versions, tags, commit ids
    # CheckURI: https://github.com/sstephenson/rbenv
    # CheckURI: https://github.com/sstephenson/ruby-build
    $gitRef_rbenv     = '8ee2f265'
    $gitRef_rubyBuild = v20121227


    ### Package
    $require = [
        Package['git'],
        Package['ruby'],
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
