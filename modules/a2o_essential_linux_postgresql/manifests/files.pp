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



### Files: config
class   a2o_essential_linux_postgresql::files::config   inherits   a2o_essential_linux_postgresql::base {

    File {
        owner    => root,
        group    => root,
        mode     => 644,
    }

    # Dirs
    file { '/etc/postgresql':   ensure => directory, mode => 755 }

    # Files
    file { '/etc/postgresql/postgresql.conf':
        ensure => present,
        mode   => 644,
    }
    file { '/etc/postgresql/pg_hba.conf':
        ensure => present,
        group  => postgresql,
        mode   => 640,
    }
    file { '/etc/postgresql/pg_ident.conf':
        ensure => present,
        group  => postgresql,
        mode   => 640,
    }
}



### Files: runtime
class   a2o_essential_linux_postgresql::files::runtime   inherits   a2o_essential_linux_postgresql::base {

    File {
        owner    => postgresql,
        group    => postgresql,
        mode     => 644,
        require  => User['postgresql'],
    }

    file { '/var/postgresql':        ensure => directory, mode => 755 }
    file { '/var/postgresql/data':   ensure => directory, mode => 700 }
    file { '/var/postgresql/log':    ensure => directory, mode => 755 }
    file { '/var/postgresql/run':    ensure => directory, mode => 755 }
}



### Files: helpers
#class   a2o_essential_linux_postgresql::files::runtime   inherits   a2o_essential_linux_postgresql::base {

    # Database dump and restore files
#    file { '/opt/scripts/postgresql':   ensure => directory, mode => 755 }
#    file { '/opt/scripts/postgresql/dump.config.defaults':   source => "puppet:///modules/$thisPuppetModule/dump.config.defaults" }
#    file { '/opt/scripts/postgresql/dump.postgresql.sh':          source => "puppet:///modules/$thisPuppetModule/dump.postgresql.sh"        }
#    file { '/opt/scripts/postgresql/import.postgresql.sh':        source => "puppet:///modules/$thisPuppetModule/import.postgresql.sh"      }
#}



### Include-all files
class   a2o_essential_linux_postgresql::files {
    include 'a2o_essential_linux_postgresql::files::config'
    include 'a2o_essential_linux_postgresql::files::runtime'
#    include 'a2o_essential_linux_postgresql::files::helpers'
}
