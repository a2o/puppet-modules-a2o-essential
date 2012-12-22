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



### Required users and groups
class   a2o_essential_linux_postfix::users_groups_pa {

    $user = 'postfix'
    $uid  = '25'
    $gid  = '25'
    $home = '/var/postfix'

    # Create group, user, homedir
    a2o-essential-unix::usergroup::daemon { "$user":
	uid    => "$uid",
	gid    => "$gid",
	home   => "$home",
	shell  => '/bin/false',
	groups => ['clamav'],
    }

    # Additional group
    group { 'postdrop':   ensure => present, gid => 26, before => User['postfix'] }

    # Vacation user
    a2o-essential-unix::usergroup::daemon { 'vacation':
	group => 'vacation',
	uid   => 27,
	gid   => 27,
	home  => '/var/postfix/vacation',
	shell => '/bin/false',
    }
    Group['clamav'] -> User['vacation'] -> User['postfix']
}
