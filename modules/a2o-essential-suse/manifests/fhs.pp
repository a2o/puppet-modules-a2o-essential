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



### Filesystem Hierarchy Standard directories - SuSE distribution specific
class a2o-essential-suse::fhs inherits a2o-essential-suse::base {

    File {
	ensure   => directory,
        owner    => root,
        group    => root,
        mode     => 755,
    }

    file { '/etc/init.d':   }
    file { '/etc/rc.d':     ensure => 'init.d', }
    file { '/home':         links  => follow }
    file { '/proc':         mode   => 555 }
    file { '/root':         mode   => 700 }
}
