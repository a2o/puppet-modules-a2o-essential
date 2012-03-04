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
# Authors: Bostjan Skufca <bostjan@a2o.si>                                #
###########################################################################



### Filesystem Hierarchy Standard directories
class a2o-essential-unix::fhs inherits a2o-essential-unix::base {

    File {
	ensure   => directory,
        owner    => root,
        group    => root,
        mode     => 755,
    }

    file { '/bin':                 }
    file { '/boot':                }
    file { '/dev':                 }
    file { '/etc':                 }
    # /etc/rc.d is env-dependent (symlink or dir)
    # /home     is env-dependent (symlink or dir)
    file { '/lib':                 }
    file { '/mnt':                 }
    file { '/opt':                 }
    file { '/opt/daemons':         }
    file { '/opt/scripts':         }
    file { '/proc':                }
    file { '/root':                mode => 710, }
    file { '/sbin':                }
    file { '/srv':                 }
    file { '/sys':                 }
    file { '/tmp':                 mode => 1777, }

    file { '/usr':                 }
    file { '/usr/bin':             }
    file { '/usr/etc':             }
    file { '/usr/include':         }
    file { '/usr/lib':             }
    file { '/usr/libexec':         }
    file { '/usr/man':             }
    file { '/usr/sbin':            }
    file { '/usr/share':           }
    file { '/usr/src':             }
    file { '/usr/tmp':             ensure => '/var/tmp', }

    file { '/usr/local':           }
    file { '/usr/local/bin':       }
    file { '/usr/local/etc':       }
    file { '/usr/local/include':   }
    file { '/usr/local/lib':       }
    file { '/usr/local/libexec':   }
    file { '/usr/local/man':       }
    file { '/usr/local/sbin':      }
    file { '/usr/local/share':     }
    file { '/usr/local/var':       }

    file { '/var':                 }
    file { '/var/lib':             }
    file { '/var/log':             }
    file { '/var/log/old':         }
    # TODO rename /var/log/old to /var/log/archive(s)
    #file { '/var/log/archive':    }
    file { '/var/run':             }
    file { '/var/spool':           }
    file { '/var/tmp':             mode => 1777, }
    file { '/var/www':             mode => 775,  group => undef, }

    # Empty dir
    file { '/var/empty':
	# Do not ensure empty - cPanel has some ssh stuff in there
	#source  => "puppet:///modules/$thisPuppetModule/empty",
	#recurse => true,
	#purge   => true,
	#force   => true,
    }
}
