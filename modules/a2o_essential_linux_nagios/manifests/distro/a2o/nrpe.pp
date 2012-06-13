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



### Service: nrpe
class   a2o_essential_linux_nagios::distro::a2o::nrpe::service   inherits   a2o_essential_linux_nagios::base {

    $requireDefs = [
        File['/etc/nrpe'],
    ]
    $subscribeDefs = [
	Package['nrpe'],
	Package['nagios-plugins'],
        File['/usr/local/nrpe'],
        File['/usr/local/nagios-plugins'],
        File['/etc/nrpe/nrpe.cfg'],
        File['/etc/nrpe/commands.cfg'],
    ]

    a2o-essential-unix::rctool::service::generic { 'nrpe':
        require   => $requireDefs,
        subscribe => $subscribeDefs,
    }
}



### Final all-containing class
class a2o_essential_linux_nagios::distro::a2o::nrpe {
    include 'a2o_essential_linux_nagios::package::nrpe'
    include 'a2o_essential_linux_nagios::package::nagios_plugins'
    include 'a2o_essential_linux_nagios::files::common'
    include 'a2o_essential_linux_nagios::files::nrpe'
    include 'a2o_essential_linux_nagios::distro::a2o::nrpe::service'
}
