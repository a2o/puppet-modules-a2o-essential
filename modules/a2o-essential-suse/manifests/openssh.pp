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



### OpenSSH - Secure SHell
class   a2o-essential-suse::openssh   inherits   a2o-essential-suse::base {

    ### Software and configuration file
    package { 'openssh':
	provider => zypper,
	ensure   => present,
    }
    file { '/etc/ssh/sshd_config':
	source   => "puppet:///modules/$thisPuppetModule/sshd_config",
	owner    => root,
	group    => root,
	mode     => 640,
	require  => Package['openssh'],
    }


    ### Service
    $subscribeDefs = [
	Package['openssh'],
	File['/etc/ssh/sshd_config'],
    ]
    a2o-essential-suse::service::generic { 'sshd':   subscribe => $subscribeDefs }
}
