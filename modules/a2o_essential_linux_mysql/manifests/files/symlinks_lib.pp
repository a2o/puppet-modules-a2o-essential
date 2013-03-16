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
class   a2o_essential_linux_mysql::files::symlinks_lib   inherits   a2o_essential_linux_mysql::base {

    # Template
    File {
        owner    => root,
        group    => root,
        mode     => 755,
        require  => File['/usr/local/mysql'],
    }

    # Library symlink - FIXME why? Postfix again?
    file { '/usr/lib/libmysqlclient.so'     :   ensure => link, target => '/usr/local/mysql/lib/mysql/libmysqlclient.so',          backup => false }
    file { '/usr/lib/libmysqlclient_r.so'   :   ensure => link, target => '/usr/local/mysql/lib/mysql/libmysqlclient_r.so',        backup => false }
    file { '/usr/lib/libmysqlclient.so.16'  :   ensure => link, target => '/usr/local/mysql-5.1/lib/mysql/libmysqlclient.so.16',   backup => false }
    file { '/usr/lib/libmysqlclient_r.so.16':   ensure => link, target => '/usr/local/mysql-5.1/lib/mysql/libmysqlclient_r.so.16', backup => false }

    if $version_major == '5.5' {
#	file { '/usr/lib/libmysqlclient.so.18'  :   ensure => link, target => '/usr/local/mysql-5.5/lib/mysql/libmysqlclient.so.16',   backup => false }
#	file { '/usr/lib/libmysqlclient_r.so.18':   ensure => link, target => '/usr/local/mysql-5.5/lib/mysql/libmysqlclient_r.so.16', backup => false }
    }
}
