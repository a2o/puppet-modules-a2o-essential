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



define   a2o-essential-unix::account::shell::root (
    $ensure = 'present',
    $password,
    $authorizedKeysUri = undef
) {

    ###
    ### Get username from resource name
    ###
    $userName = "root_${name}"


    # User
    user { "$userName":
	ensure      => $ensure,
	allowdupe   => true,

	uid         => 0,
	gid         => 0,
	shell       => '/bin/bash',
	managehome  => true,

	password         => "$password",
	password_min_age => 0,
	password_max_age => 99999,
    }


    # File template
    File {
	require => User["$userName"],
	owner   => root,
	group   => root,
    }


    # Directories
    file {"/home/$userName":        ensure => directory, mode => 700 }
    file {"/home/$userName/.ssh":   ensure => directory, mode => 700 }


    # SSH authorized keys file
    if $authorizedKeysUri != undef {
	$authorizedKeysUriReal = $authorizedKeysUri
    } else {
	$authorizedKeysUriReal = [
	    "puppet:///modules/$thisPuppetModule/authorized_keys.$userName",
	    "puppet:///modules/a2o-essential-unix/account/shell/authorized_keys.root.empty",
	]
    }
    file { "/home/$userName/.ssh/authorized_keys":
	source  => $authorizedKeysUriReal,
	mode    => 600,
    }


    # Symlinks
    file { "/home/$userName/.my.cnf":   ensure => link, target => '/root/.my.cnf' }
    file { "/home/$userName/.mytop":    ensure => link, target => '/root/.mytop'  }
}
