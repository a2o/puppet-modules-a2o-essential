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



### Service: ntpd
class   a2o_essential_linux_ntp::distro::a2o::service   inherits   a2o_essential_linux_ntp::package::base {

    ### Requires and subscribes
    $require   = [
        File['/var/ntp'],
	File['/opt/scripts/cron/run-and-mail-if-error.sh'],
	File['/opt/scripts/ntp/conditional-ntpdate.sh'],
    ]
    $subscribe = [
	Package['ntp'],
        File['/etc/ntp.conf'],
    ]

    ### Instantiate from template
    a2o-essential-unix::rctool::service::generic { 'ntpd':
	require   => $require,
	subscribe => $subscribe,
    }
}



### The final all-containing classes
class a2o_essential_linux_ntp::distro::a2o {
    include 'a2o_essential_linux_ntp::package::ntp'
    include 'a2o_essential_linux_ntp::files::daemon'
    include 'a2o_essential_linux_ntp::distro::a2o::service'
    include 'a2o_essential_linux_ntp::cron'
}
