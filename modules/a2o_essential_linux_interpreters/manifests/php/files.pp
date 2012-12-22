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



### Files for: php
class   a2o_essential_linux_interpreters::php::files   inherits   a2o_essential_linux_interpreters::php::base {

    File {
	require  => File['/usr/local/php-cli'],
	backup   => false,
	owner    => root,
	group    => root,
    }

    # Directories
    file { '/etc/php':              ensure => directory, mode => 755 }
    file { '/etc/php/cli':          ensure => directory, mode => 755 }
    file { '/etc/php/cli/conf.d':   ensure => directory, mode => 755 }

    # PHP runtime dirs
    file { '/var/tmp/php':            ensure => directory               }
    file { '/var/tmp/php/sessions':   ensure => directory, mode => 1777 }
    file { '/var/tmp/php/soap':       ensure => directory, mode => 1777 }
    file { '/var/tmp/php/uploads':    ensure => directory, mode => 1777 }

    # Config files
    file { '/etc/php/cli/php.ini':
	source   => "puppet:///modules/$thisPuppetModule/php.ini",
        mode     => 644,
    }
}
