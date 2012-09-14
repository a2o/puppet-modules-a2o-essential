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



### Cron for time check and conditional ntpdate run
class   a2o_essential_linux_ntp::cron   inherits   a2o_essential_linux_ntp::base {

    File {
        owner    => root,
        group    => root,
	mode     => 755,
    }
    file { '/opt/scripts/ntp':                          ensure => directory }
    file { '/opt/scripts/ntp/conditional-ntpdate.sh':   source => "puppet:///modules/$thisPuppetModule/conditional-ntpdate.sh" }

    cron { '/opt/scripts/ntp/conditional-ntpdate.sh':
	user     => root,
        minute   => 57,
	hour     => 0,
        command  => '/opt/scripts/cron/run-and-mail-if-error.sh   "/opt/scripts/ntp/conditional-ntpdate.sh"   "root"',
	require  => [
	    Package['ntp'],
	    File['/opt/scripts/cron/run-and-mail-if-error.sh'],
	],
    }
}
