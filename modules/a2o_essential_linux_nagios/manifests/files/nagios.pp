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



### Nagios directories and files
class   a2o_essential_linux_nagios::files::nagios   inherits   a2o_essential_linux_nagios::base {

    File {
	ensure => directory,
	owner  => nagios,
	group  => nagios,
        mode   => 755,
    }

    # Nagios runtime dirs
#    file { '/var/nagios':       }   # Defined in common files class
    file { '/var/nagios/cache': }
    file { '/var/nagios/log':   }
    file { '/var/nagios/log/archives':   }
    file { '/var/nagios/rrd':   }
    file { '/var/nagios/run':   }
    file { '/var/nagios/rw':    mode => 2775 }
    file { '/var/nagios/spool': mode =>  775 }
    file { '/var/nagios/stats': }
    file { '/var/nagios/tmp':   }

    # Log dir symlink
    file { '/var/log/nagios':   ensure => '/var/nagios/log', }
}
