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



### Network time protocol - clock synchronisation
class   a2o-essential-suse::ntp   inherits   a2o-essential-suse::base {

    ### Package name
    case $operatingsystem {
	opensuse: {
	    case $operatingsystemrelease {
		10.3: {
		    $packageName = "xntp"
		}
		default: {
		    $packageName = "ntp"
		}
	    }
	}
	default: {
	    $packageName = "ntp"
	}
    }


    ### Software and configuration file
    package { "$packageName":
	provider => zypper,
	ensure   => present,
    }
    file { '/etc/ntp.conf':
	source   => "puppet:///modules/$thisPuppetModule/ntp.conf",
	owner    => root,
	group    => ntp,
	mode     => 644,
	require  => Package["$packageName"],
    }


    ### Service - DISABLED BECAUSE IT MIGHT HANG THE SERVER AT BOOT
    $subscribeDefs = [
	Package["$packageName"],
	File['/etc/ntp.conf'],
    ]
    a2o-essential-suse::service::generic { 'ntp':   ensure => disabled, subscribe => $subscribeDefs }
}
