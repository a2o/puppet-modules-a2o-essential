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



### NRPE directories and files
class   a2o_essential_linux_nagios::files::nrpe   inherits   a2o_essential_linux_nagios::base {

    File {
	owner => root,
	group => root,
    }

    file { '/etc/nrpe':                ensure => directory, mode => 750 }
    file { '/etc/nrpe/conf.d':         ensure => directory, mode => 750 }
    file { '/etc/nrpe/nrpe.cfg':       ensure => present,   content => template("$thisPuppetModule/nrpe.cfg"),     mode => 640 }
    file { '/etc/nrpe/commands.cfg':   ensure => present,   content => template("$thisPuppetModule/commands.cfg"), mode => 640 }

    # Compatibility
    file { '/etc/nagios/nrpe':     ensure => '/etc/nrpe' }
}
