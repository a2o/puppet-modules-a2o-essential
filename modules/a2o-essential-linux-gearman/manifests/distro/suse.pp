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



### Base class
class   a2o-essential-linux-gearman::distro::suse::base   inherits   a2o-essential-linux-gearman::base {
}



### Service: gearmand
class   a2o-essential-linux-gearman::distro::suse::service   inherits   a2o-essential-linux-gearman::distro::suse::base {

    # Service details
    $serviceName      = 'gearmand'
    $serviceState     = 'running'

    # Startup file
    file { "/etc/init.d/$serviceName":
        source   => "puppet:///modules/$thisPuppetModule/suse/$serviceName",
        owner    => root,
        group    => root,
        mode     => 755,
        require  => [
	    Package['gearman'],
            File['/usr/local/gearman'],
        ],
    }


    # Service definition
    service { "$serviceName":
        enable      => $serviceState ? {
	    running => true,
	    stopped => false,
	    default => false,
	},
        ensure      => $serviceState,
        provider    => 'redhat',
        subscribe   => [
            Package['gearman'],
            File['/usr/local/gearman'],
            File['/var/gearman'],
            File['/var/gearman/run'],
            File["/etc/init.d/$serviceName"],
        ],
    }
}



### Final all-containing class
class a2o-essential-linux-gearman::distro::suse {
    include 'a2o-essential-linux-gearman'
    include 'a2o-essential-linux-gearman::distro::suse::service'
}
