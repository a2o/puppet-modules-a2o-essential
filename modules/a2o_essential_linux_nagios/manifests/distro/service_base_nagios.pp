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



### Service base class: nagios
class   a2o_essential_linux_nagios::distro::service_base_nagios   inherits   a2o_essential_linux_nagios::base {

    # External resources
    $destDir_openssl = $a2o_essential_linux_nagios::package::base::externalDestDir_openssl
    $destDir_mysql   = $a2o_essential_linux_nagios::package::base::externalDestDir_mysql


    $require   = [
        File['/etc/nagios'],
    ]

    $subscribe = [
	Package['nagios'],
	Package['nagios-plugins'],
	Package[$a2o_essential_linux_nagios::package::base::softwareName_mk_livestatus],
	Package[$a2o_essential_linux_nagios::package::base::softwareName_pnp4nagios],
        File['/usr/local/nagios'],
        File['/usr/local/nagios-plugins'],
    ]
}
