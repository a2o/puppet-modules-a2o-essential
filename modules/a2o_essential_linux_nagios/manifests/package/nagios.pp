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



### Software package: nagios
class   a2o_essential_linux_nagios::package::nagios   inherits   a2o_essential_linux_nagios::package::base {

    # Package / Software details
    # CheckURI: see base.pp file for upgrading
    $softwareName     = "$softwareName_nagios"
    $softwareVersion  = "$softwareVersion_nagios"
    $packageRelease   = "$packageRelease_nagios"
    $packageTag       = "$packageTag_nagios"
    $destDir          = "$destDir_nagios"


    ### Additinal versions
    $externalDestDir_perl    = '/usr/local/perl-5.14.2-1'
    $externalDestDir_openssl = '/usr/local/openssl-1.0.0i-1'


    ### Package
    $require = [
        Package['perl'],
        Package['openssl'],
        User['nagios'],
        User['nagcmd'],
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
