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



### Required users and groups
class   a2o_essential_linux_nagios::users_groups {

    group { 'nagios':    ensure => present, gid => 1248, }
    group { 'nagcmd':    ensure => present, gid => 1249, }

    User  {
        provider   => useradd,
        allowdupe  => false,
	ensure     => present,
        password   => '*',
        shell      => '/bin/bash',
        managehome => true,
    }
    user  { 'nagios':   require => Group['nagios'], uid => 1248, gid => 1248, home => '/var/nagios',    }
    user  { 'nagcmd':   require => Group['nagcmd'], uid => 1249, gid => 1249, home => '/var/nagios/rw', }
}
