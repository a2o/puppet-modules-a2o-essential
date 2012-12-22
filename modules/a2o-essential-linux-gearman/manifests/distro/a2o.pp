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



### Base class
class   a2o-essential-linux-gearman::distro::a2o::base   inherits   a2o-essential-linux-gearman::base {
}



### Service: gearmand
class   a2o-essential-linux-gearman::distro::a2o::service   inherits   a2o-essential-linux-gearman::distro::a2o::base {

    # Service details
    $serviceName      = 'gearmand'
    $serviceState     = 'running'

    # Startup file
    file { "/etc/rc.d/rc.$serviceName":
        source   => "puppet:///modules/$thisPuppetModule/a2o/rc.$serviceName",
        owner    => root,
        group    => root,
        mode     => $serviceState ? {
	    running => 755,
	    stopped => 644,
	    default => 644,
	},
	require  => File['/etc/rc.tool/common'],
    }


    # Service definition
    service { "a2o-linux-$serviceName":
        enable      => $serviceState ? {
	    running => true,
	    stopped => false,
	    default => false,
	},
        ensure      => $serviceState,
	hasrestart  => true,
        hasstatus   => true,
        provider    => 'a2o_linux_rctool',
        binary      => "/etc/rc.d/rc.$serviceName",
        start       => "/etc/rc.d/rc.$serviceName start",
        restart     => "/etc/rc.d/rc.$serviceName restart",
        stop        => "/etc/rc.d/rc.$serviceName stop",
        status      => "/etc/rc.d/rc.$serviceName status",
        subscribe   => [
            Package['gearman'],
            File['/usr/local/gearman'],
            File['/var/gearman'],
            File['/var/gearman/run'],
            File["/etc/rc.d/rc.$serviceName"],
        ],
        require     => [
            Package['gearman'],
            File['/usr/local/gearman'],
            File['/var/gearman'],
            File['/var/gearman/run'],
            File["/etc/rc.d/rc.$serviceName"],
        ],
    }
}



### Final all-containing class
class a2o-essential-linux-gearman::distro::a2o {
    include 'a2o-essential-linux-gearman'
    include 'a2o-essential-linux-gearman::distro::a2o::service'
}
