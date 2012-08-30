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



### Various system things
class   a2o-essential-unix::sys::time   inherits   a2o-essential-unix::base {

    ### Sync time with pool.ntp.org
    cron { 'ntpdate pool.ntp.org':
        user     => root,
	command  => '/opt/scripts/cron/run-and-mail-if-error.sh   "ntpdate pool.ntp.org"   "root"',
	minute   => 59,
	require  => [
	    Package['ntp'],
    	    File['/opt/scripts/cron/run-and-mail-if-error.sh'],
	],
    }

    ### Sync hardware clock to system time from cron
    cron { '/sbin/hwclock':
        user     => root,
	command  => '/opt/scripts/cron/run-and-mail-if-error.sh   "/sbin/hwclock --systohc"   "root"',
        hour     => 4,
	minute   => 1,
	require  => [
    	    File['/opt/scripts/cron/run-and-mail-if-error.sh'],
	],
    }
}



### Include all
class   a2o-essential-unix::sys {
    include 'a2o-essential-unix::sys::time'
}
