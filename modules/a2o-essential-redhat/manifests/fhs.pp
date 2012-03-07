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



### Filesystem Hierarchy Standard directories - redhat distribution specific
class   a2o-essential-redhat::fhs   inherits   a2o-essential-redhat::base {

    File {
	ensure   => directory,
        owner    => root,
        group    => root,
        mode     => 755,
    }

    file { '/etc/init.d':   ensure => 'rc.d/init.d' }
    file { '/etc/rc.d':     }
    file { '/home':         }
    file { '/proc':         mode => 555 }
    file { '/root':         mode => 550 }
}