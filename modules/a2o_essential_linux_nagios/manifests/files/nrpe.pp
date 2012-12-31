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



### Base class
class   a2o_essential_linux_nagios::files::nrpe::base   inherits   a2o_essential_linux_nagios::base {

    File {
	owner => root,
	group => root,
    }
}



### Directories
class   a2o_essential_linux_nagios::files::nrpe::dirs   inherits   a2o_essential_linux_nagios::files::nrpe::base {

    file { '/etc/nrpe':                ensure => directory, mode => 755 }
    file { '/etc/nrpe/conf.d':         ensure => directory, mode => 755 }
    file { '/etc/nrpe/plugins':        ensure => directory, mode => 755 }

    # Compatibility
    file { '/etc/nagios/nrpe':         ensure => link, target => '/etc/nrpe' }
}



### Main config files
class   a2o_essential_linux_nagios::files::nrpe::config   inherits   a2o_essential_linux_nagios::files::nrpe::base {

    file { '/etc/nrpe/nrpe.cfg':       ensure => present,   content => template("$thisPuppetModule/nrpe.cfg"),     mode => 640 }
    file { '/etc/nrpe/commands.cfg':   ensure => present,   content => template("$thisPuppetModule/commands.cfg"), mode => 640 }
}



### Custom plugins
class   a2o_essential_linux_nagios::files::nrpe::plugins   inherits   a2o_essential_linux_nagios::files::nrpe::base {

    File {
	require => Package['nagios-plugins'],
	before  => File['/usr/local/nagios-plugins'],
	mode    => 755,
    }

    file { '/etc/nrpe/plugins/check_dns_host':           source  => "puppet:///modules/$thisPuppetModule/check_dns_host"         }
    file { '/etc/nrpe/plugins/check_dns_host_reverse':   source  => "puppet:///modules/$thisPuppetModule/check_dns_host_reverse" }
    file { '/etc/nrpe/plugins/check_gmond':              source  => "puppet:///modules/$thisPuppetModule/check_gmond"            }
}



### All together now
class   a2o_essential_linux_nagios::files::nrpe {
    include 'a2o_essential_linux_nagios::files::nrpe::dirs'
    include 'a2o_essential_linux_nagios::files::nrpe::config'
    include 'a2o_essential_linux_nagios::files::nrpe::plugins'
}
