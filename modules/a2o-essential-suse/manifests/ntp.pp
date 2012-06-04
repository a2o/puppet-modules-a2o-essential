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



### Network time protocol - clock synchronisation
class   a2o-essential-suse::ntp   inherits   a2o-essential-suse::base {

    ### Software and configuration file
    package { 'ntp':
	provider => zypper,
	ensure   => present,
    }
    file { '/etc/ntp.conf':
	source   => "puppet:///modules/$thisPuppetModule/ntp.conf",
	owner    => root,
	group    => ntp,
	mode     => 644,
	require  => Package['ntp'],
    }


    ### Service
    $subscribeDefs = [
	Package['ntp'],
	File['/etc/ntp.conf'],
    ]
    a2o-essential-suse::service::generic { 'ntp':   subscribe => $subscribeDefs }


    ### Sync hardware clock to system time from cron
    cron { '/sbin/hwclock':
	user     => root,
	command  => '/opt/scripts/cron/run-and-mail-if-error.sh   "/sbin/hwclock --systohc"   "root"',
	hour     => 4,
	minute   => 1,
	require  => [
	    Service['ntp'],
	    File['/opt/scripts/cron/run-and-mail-if-error.sh'],
	],
    }
}
