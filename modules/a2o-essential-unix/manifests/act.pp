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



### ACT - a2o Compile Tool
class   a2o-essential-unix::act   inherits   a2o-essential-unix::base {

    # Template
    File {
	owner   => root,
	group   => root,
    }


    # ACT configuration and runtime directories
    file { [
	'/etc/act',
	'/etc/act/conf.d',
	'/var/lib/act',
	]:
	ensure  => directory,
	mode    => 755,
    }

    # Future build status and log directories - currenly only a symlink
    file { '/var/lib/act/status':
	ensure  => link,
	target  => '/var/log/packages_compiled',
	require => [
	    File['/var/log/packages_compiled'],
	],
    }


    # ACT configuration
    file { '/etc/act/act.conf':
	mode    => 644,
	source  => "puppet:///modules/$thisPuppetModule/act/act.conf",
	require => [
	    File['/etc/act'],
	],
    }


    # ACT build/install functions
    file { '/var/src/act_functions.sh':
	mode    => 755,
	source  => "puppet:///modules/$thisPuppetModule/act/act_functions.sh",
	require => [
	    File['/etc/act/act.conf'],
	    File['/etc/act/conf.d'],
	    File['/var/lib/act/status'],
	],
    }
}
