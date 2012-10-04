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



### Service base class: nrpe
class   a2o_essential_linux_nagios::distro::service_base_nrpe   inherits   a2o_essential_linux_nagios::base {

    # External resources
    $destDir_openssl = $a2o_essential_linux_nagios::package::base::externalDestDir_openssl
    $destDir_mysql   = $a2o_essential_linux_nagios::package::base::externalDestDir_mysql


    $require   = [
        File['/etc/nrpe'],
    ]

    $subscribe = [
	Package['nrpe'],
	Package['nagios-plugins'],
        File['/usr/local/nrpe'],
        File['/usr/local/nagios-plugins'],
        File['/etc/nrpe/nrpe.cfg'],
        File['/etc/nrpe/commands.cfg'],
    ]
}
