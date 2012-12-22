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



### Symlinks to programs and directories
class   a2o_essential_linux_mysql::files::symlinks   inherits   a2o_essential_linux_mysql::base {

    # Template
    File {
        owner    => root,
        group    => root,
        mode     => 755,
	require  => File['/usr/local/mysql'],
    }

    # Program symlinks
    file { '/usr/local/bin/mysql':        ensure => '/usr/local/mysql/bin/mysql',      }
    file { '/usr/local/bin/mysqladmin':   ensure => '/usr/local/mysql/bin/mysqladmin', }
    file { '/usr/local/bin/mysqldump':    ensure => '/usr/local/mysql/bin/mysqldump',  }
    file { '/usr/local/bin/myisamchk':    ensure => '/usr/local/mysql/bin/myisamchk',  }

    # Log directory symlink
    file { '/var/log/mysql':
	ensure   => '/var/mysql/log',
    }
}
