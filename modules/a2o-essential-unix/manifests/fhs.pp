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



### Filesystem Hierarchy Standard directories
class a2o-essential-unix::fhs inherits a2o-essential-unix::base {

    $mode_osdep = $operatingsystem ? {
	redhat  => 555,
	default => 755,
    }

    File {
	ensure   => directory,
        owner    => root,
        group    => root,
        mode     => 755,
    }

    file { '/bin':                 mode => $mode_osdep, }
    file { '/boot':                mode => $mode_osdep, }
    file { '/dev':                 }
    file { '/etc':                 }
    # /etc/rc.d is env-dependent (symlink or dir)
    # /home     is env-dependent (symlink or dir)
    file { '/lib':                 mode => $mode_osdep, }
    file { '/mnt':                 }
    file { '/opt':                 }
    file { '/opt/daemons':         }
    file { '/opt/scripts':         }
#    file { '/proc':                }   # SuSE 555
#    file { '/root':                mode => 710, }   # SuSE 700
    file { '/sbin':                mode => $mode_osdep, }
    file { '/srv':                 }
    file { '/sys':                 }
    file { '/tmp':                 mode => 1777, }

    file { '/usr':                 }
    file { '/usr/bin':             mode => $mode_osdep, }
    file { '/usr/etc':             }
    file { '/usr/include':         }
    file { '/usr/lib':             mode => $mode_osdep, }
    file { '/usr/libexec':         }
    file { '/usr/man':             }
    file { '/usr/sbin':            mode => $mode_osdep, }
    file { '/usr/share':           }
    file { '/usr/src':             group => undef, mode => undef }
#    file { '/usr/tmp':             ensure => '/var/tmp', }   # SuSE ../var/tmp

    file { '/usr/local':           group => undef, mode => undef }
    file { '/usr/local/bin':       group => undef, mode => undef }
    file { '/usr/local/etc':       group => undef, mode => undef }
    file { '/usr/local/include':   group => undef, mode => undef }
    file { '/usr/local/lib':       group => undef, mode => undef }
    file { '/usr/local/libexec':   group => undef, mode => undef }
#    file { '/usr/local/man':       group => undef, mode => undef } # Debian symlink to share/man
    file { '/usr/local/sbin':      group => undef, mode => undef }
    file { '/usr/local/share':     group => undef, mode => undef }
    file { '/usr/local/var':       group => undef, mode => undef }

    file { '/var':                 }
    file { '/var/lib':             }
    file { '/var/log':             }
    file { '/var/log/old':         }
    # TODO rename /var/log/old to /var/log/archive(s)
    #file { '/var/log/archive':    }
    file { '/var/run':             }
    file { '/var/spool':           }
    file { '/var/tmp':             mode => 1777, }
    file { '/var/www':             mode => undef,  group => undef, }

    # Empty dir
    file { '/var/empty':
	# Do not ensure empty - cPanel has some ssh stuff in there
	#source  => "puppet:///modules/$thisPuppetModule/empty",
	#recurse => true,
	#purge   => true,
	#force   => true,
    }
}
