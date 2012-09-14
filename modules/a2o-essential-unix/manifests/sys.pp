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

    ### Sync hardware clock to system time once per day
    File {
        owner    => root,
        group    => root,
        mode     => 755,
    }
    file { '/opt/scripts/clock':              ensure => directory }
    file { '/opt/scripts/clock/hwclock.sh':   source => "puppet:///modules/$thisPuppetModule/scripts/clock/hwclock.sh" }

    cron { '/opt/scripts/clock/hwclock.sh':
        user     => root,
	command  => '/opt/scripts/cron/run-and-mail-if-error.sh   "/opt/scripts/clock/hwclock.sh"   "root"',
        hour     => 4,
	minute   => 1,
	require  => [
    	    File['/opt/scripts/cron/run-and-mail-if-error.sh'],
	    Cron['/opt/scripts/ntp/conditional-ntpdate.sh']
	],
    }
}



### Obsolete stuff, remove at some point
class   a2o-essential-unix::sys::time_obsolete   inherits   a2o-essential-unix::base {

    # FIXME remove in future, disabled on 2012-09-13
    ### Sync time with pool.ntp.org
    cron { 'ntpdate pool.ntp.org':
        user     => root,
	command  => '/opt/scripts/cron/run-and-mail-if-error.sh   "ntpdate pool.ntp.org"   "root"',
	minute   => 59,
	require  => [
	    Package['ntp'],
    	    File['/opt/scripts/cron/run-and-mail-if-error.sh'],
	],
	ensure => absent,
    }
    # FIXME remove in future, disabled on 2012-09-13
    ### Sync hardware clock to system time from cron
    cron { '/sbin/hwclock':
        user     => root,
	command  => '/opt/scripts/cron/run-and-mail-if-error.sh   "/sbin/hwclock --systohc"   "root"',
        hour     => 4,
	minute   => 1,
	require  => [
    	    File['/opt/scripts/cron/run-and-mail-if-error.sh'],
	],
	ensure => absent,
    }
}



### Obligatory stuff for all servers
class   a2o-essential-unix::sys {
    ### Time sync and machine clock sync
    include 'a2o_essential_linux_ntp::cron'
    include 'a2o-essential-unix::sys::time'
    include 'a2o-essential-unix::sys::time_obsolete'
}
