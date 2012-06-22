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



### System users and groups
class   a2o_essential_linux_postgresql::users_groups   inherits   a2o_essential_linux_postgresql::base {

    group { 'postgresql':
	ensure     => present,
	gid        => 5432,
    }

    user  { 'postgresql':
	require    => Group['postgresql'],
	ensure     => present,
	provider   => useradd,
	allowdupe  => false,
	password   => '*',
	uid        => 5432,
	gid        => 5432,
	shell      => '/bin/bash',
	home       => '/var/postgresql',
	managehome => false,
    }
}
