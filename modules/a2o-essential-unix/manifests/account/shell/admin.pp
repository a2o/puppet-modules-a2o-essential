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



define   a2o-essential-unix::account::shell::admin (
    $ensure = 'present',
    $password,
    $uid,
    $authorizedKeysUri = undef
) {

    ###
    ### Get username from resource name
    ###
    $userName = "$name"


    # User
    user { "$userName":
	ensure      => $ensure,
	allowdupe   => false,

	uid         => "$uid",
	gid         => users,
	shell       => '/bin/bash',
	managehome  => true,

	password         => "$password",
	password_min_age => 0,
	password_max_age => 99999,

	groups      => $operatingsystem ? {
	    slackware => [
		'root',
		'admin',
	    ],
	    default   => fail('Unsupported operating system'),
	}
    }


    # File template
    File {
	require => User["$userName"],
	owner   => "$userName",
	group   => users,
    }


    # Directories
    file {"/home/$userName":        ensure => directory, mode => 755 }
    file {"/home/$userName/.ssh":   ensure => directory, mode => 700 }


    # SSH authorized keys file
    if $authorizedKeysUri != undef {
	$authorizedKeysUriReal = $authorizedKeysUri
    } else {
	$authorizedKeysUriReal = [
	    "puppet:///modules/$thisPuppetModule/authorized_keys.$userName",
	    "puppet:///modules/a2o-essential-unix/account/shell/authorized_keys.admin.empty",
	]
    }
    file { "/home/$userName/.ssh/authorized_keys":
	source  => $authorizedKeysUriReal,
	mode    => 600,
    }
}
