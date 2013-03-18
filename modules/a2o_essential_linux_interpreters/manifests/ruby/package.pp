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



### Software package: ruby
class   a2o_essential_linux_interpreters::ruby::package   inherits   a2o_essential_linux_interpreters::ruby::base {

    # Package / Software details
    # CheckURI: http://www.ruby-lang.org/en/downloads/
    # CheckURI: http://ftp.ruby-lang.org/pub/ruby/
    $softwareName     = 'ruby'
    $softwareVersion  = '1.9.3_p392'
    $packageRelease   = '1'
    $packageTag       = "$softwareName-$softwareVersion-$packageRelease"
    $destDir          = "/usr/local/$packageTag"

    ### Additinal versions
    # CheckURI: http://rubygems.org/
    # WARNING: Do not upgrade past 1.8 without thorough testing, namely with Redmine
    $softwareVersion_gems = '1.8.25'

    ### External dependencies
    $externalDestDir_openssl = '/usr/local/openssl-1.0.1e-2'


    ### Package
    $require = [
        Package['openssl'],
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
