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



### Service: nagios
class   a2o_essential_linux_nagios::distro::suse::nagios::service   inherits   a2o_essential_linux_nagios::base {

    $requireDefs = [
        File['/etc/nagios'],
    ]
    $subscribeDefs = [
	Package['nagios'],
	Package['nagios-plugins'],
	Package[$a2o_essential_linux_nagios::package::base::softwareName_mk_livestatus],
	Package[$a2o_essential_linux_nagios::package::base::softwareName_pnp4nagios],
        File['/usr/local/nagios'],
        File['/usr/local/nagios-plugins'],
    ]

    a2o-essential-suse::service::rctool_wrapper { 'nagios':
        require   => $requireDefs,
        subscribe => $subscribeDefs,
    }
}



### Final all-containing class
class   a2o_essential_linux_nagios::distro::suse::nagios {
    include 'a2o_essential_linux_nagios::users_groups'
    include 'a2o_essential_linux_nagios::package::nagios'
    include 'a2o_essential_linux_nagios::package::nagios_plugins'
    include 'a2o_essential_linux_nagios::package::pnp4nagios'
    include 'a2o_essential_linux_nagios::package::mk_livestatus'
    include 'a2o_essential_linux_nagios::files::common'
    include 'a2o_essential_linux_nagios::files::nagios'
    include 'a2o_essential_linux_nagios::distro::suse::nagios::service'
}
