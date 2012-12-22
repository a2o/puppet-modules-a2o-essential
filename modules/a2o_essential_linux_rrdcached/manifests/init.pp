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
class   a2o-essential-linux-rrdcached::base {
    $thisPuppetModule = 'a2o-essential-linux-rrdcached'
}



### Service: gmond
class   a2o-essential-linux-rrdcached::service   inherits   a2o-essential-linux-rrdcached::base {

    # Service details
    $serviceName      = 'rrdcached'
    $serviceState     = 'running'

    # Startup file
    file { "/etc/rc.d/rc.$serviceName":
        content  => template("$thisPuppetModule/rc.$serviceName"),
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
    service { "a2o-essential-linux-$serviceName":
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
	    Package['rrdtool'],
	    File["/etc/rc.d/rc.$serviceName"],
	],
	require     => [
	    Package['rrdtool'],
	    File["/etc/rc.d/rc.$serviceName"],
	],
    }
}



### The final all-containing classes
class a2o-essential-linux-rrdcached {
    include 'a2o-essential-linux-rrdcached::service'
}
