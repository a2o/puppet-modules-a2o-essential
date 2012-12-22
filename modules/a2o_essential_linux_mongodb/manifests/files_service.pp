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



### Helper files
class   a2o_essential_linux_mongodb::files_service   inherits   a2o_essential_linux_mongodb::base {

    # Template
    File {
        owner    => root,
        group    => root,
	require  => [
	    Package['mongodb'],
	    File['/usr/local/mongodb'],
	],
    }

    # Directories
    file { '/etc/mongodb':                    mode => 755, ensure => directory }
    file { '/var/mongodb':                    mode => 755, ensure => directory, owner => mongodb, group => mongodb }
    file { '/var/mongodb/data':               mode => 755, ensure => directory, owner => mongodb, group => mongodb }
    file { '/var/mongodb/log':                mode => 755, ensure => directory, owner => mongodb, group => mongodb }
    file { '/var/mongodb/run':                mode => 755, ensure => directory, owner => mongodb, group => mongodb }

    # Config file
    file { '/etc/mongodb/mongod.conf':        mode => 644, source => "puppet:///modules/$thisPuppetModule/mongod.conf" }

    # Log rotation and symlinks
    file { '/etc/logrotate.d/mongod.conf':    mode => 644, source => "puppet:///modules/$thisPuppetModule/logrotate/mongod.conf" }
    file { '/var/log/mongodb':                ensure => '/var/mongodb/log' }
}
