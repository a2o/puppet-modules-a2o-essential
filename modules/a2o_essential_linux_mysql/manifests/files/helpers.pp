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



### Helper files
class   a2o_essential_linux_mysql::files::helpers   inherits   a2o_essential_linux_mysql::base {

    # Template
    File {
        owner    => root,
        group    => root,
        mode     => 755,
    }

    # Database dump and restore files
    file { '/opt/scripts/mysql':                        ensure => directory, mode => 755 }
    file { '/opt/scripts/mysql/dump.config.defaults':   source => "puppet:///modules/$thisPuppetModule/dump.config.defaults" }
    file { '/opt/scripts/mysql/dump.mysql.sh':          source => "puppet:///modules/$thisPuppetModule/dump.mysql.sh"        }
    file { '/opt/scripts/mysql/import.mysql.sh':        source => "puppet:///modules/$thisPuppetModule/import.mysql.sh"      }
}
