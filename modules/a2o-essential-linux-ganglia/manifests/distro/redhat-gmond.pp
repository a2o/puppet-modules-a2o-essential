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



### Service: gmond
class   a2o-essential-linux-ganglia::distro::redhat-gmond::service   inherits   a2o-essential-linux-ganglia::base {

    # Service details
    $serviceName      = 'gmond'
    $serviceState     = 'running'

    # Startup file
    file { "/etc/rc.d/init.d/$serviceName":
        content  => template("$thisPuppetModule/redhat/$serviceName"),
        owner    => root,
        group    => root,
        mode     => 755,
	require  => [
	    Package['ganglia-gmond'],
	    File['/usr/local/ganglia-gmond'],
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
	    Package['ganglia-gmond'],
	    File['/etc/ganglia/gmond.conf'],
	    File['/etc/ganglia/conf.d/modpython.conf'],
	    File['/etc/ganglia/conf.d/a2o'],
	    File['/etc/ganglia/python_modules'],
	    File["/etc/rc.d/init.d/$serviceName"],
	    User['ganglia'],
	    Group['ganglia'],
	],
    }
}



### The final all-containing classes
class a2o-essential-linux-ganglia::distro::redhat-gmond {
    include 'a2o-essential-linux-ganglia::users'
    include 'a2o-essential-linux-ganglia::package::gmond'
    include 'a2o-essential-linux-ganglia::files'
    include 'a2o-essential-linux-ganglia::files::gmond'
    include 'a2o-essential-linux-ganglia::distro::redhat-gmond::service'
}
