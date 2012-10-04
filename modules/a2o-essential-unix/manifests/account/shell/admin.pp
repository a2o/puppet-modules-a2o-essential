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



define   a2o-essential-unix::account::shell::admin   ($ensure='present', $uid, $password) {

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


    # Directories and files
    file {
	[
	    "/home/$userName",
	    "/home/$userName/.ssh",
	]:
	ensure  => directory,
	require => User["$userName"],
	owner   => "$userName",
	group   => users,
	mode    => 700,
    }
    file { "/home/$userName/.ssh/authorized_keys":
	require => File["/home/$userName/.ssh"],
	owner   => "$userName",
	group   => users,
	mode    => 600,
	source  => "puppet:///modules/$thisPuppetModule/authorized_keys.$userName",
    }
}
