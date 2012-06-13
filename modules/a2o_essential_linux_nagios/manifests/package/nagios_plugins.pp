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



### Software package: nagios-plugins
class   a2o_essential_linux_nagios::package::nagios_plugins   inherits   a2o_essential_linux_nagios::package::base {

    # Package / Software details
    # CheckURI: http://www.nagios.org/download/plugins/
    $softwareName     = 'nagios-plugins'
    $softwareVersion  = '1.4.15'
    $packageRelease   = '2'
    $packageTag       = "$softwareName-$softwareVersion-$packageRelease"
    $destDir          = "/usr/local/$packageTag"


    ### Additinal versions
    $externalDestDir_perl     = '/usr/local/perl-5.14.2-1'
    $externalDestDir_openssl  = '/usr/local/openssl-1.0.0i-1'
    $externalDestDir_openldap = '/usr/local/openldap-2.4.31-1'
    $externalDestDir_mysql    = '/usr/local/mysql-5.1.63-1'


    ### Package
    $require = [
        Package['perl'],
        Package['openssl'],
        Package['openldap'],
        Package['mysql'],
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
