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



### Generic service definition: RedHat
#
# This is used as a template for service definitions in other modules
# Pass it the service name, require and subscribe definitions and it will generate
# service resource for you.

define   a2o-essential-redhat::service::rctool_wrapper   ($ensure='running', $require=[], $subscribe=[]) {


    ###
    ### Configuration
    ###
    $serviceName   = "$name"
    $serviceEnsure = "$ensure"



    ###
    ### Startup files
    ###
    file { "/etc/rc.d/rc.$serviceName":
        content  => template("$thisPuppetModule/rc.$serviceName"),
        owner    => root,
        group    => root,
        mode     => 755,
	require  => [
	    File['/etc/rc.tool/common'],
            $require,
	],
    }
    file { "/etc/init.d/$serviceName":
        content  => template("$thisPuppetModule/redhat/$serviceName"),
        owner    => root,
        group    => root,
        mode     => 755,
	require     => [
            $require,
	    $subscribe,
	    File["/etc/rc.d/rc.$serviceName"],
	    File['/etc/rc.tool/wrapper.redhat'],
        ],
    }



    ###
    ### Service definition
    ###
    service { "$serviceName":
        enable      => $serviceEnsure ? {
	    running => true,
	    stopped => false,
	    disbled => false,
	    default => false,
	},
        ensure      => $serviceEnsure ? {
	    running => running,
	    stopped => stopped,
	    disbled => stopped,
	    default => stopped,
	},
	hasrestart  => true,
        hasstatus   => true,
	provider    => 'redhat',
        require     => [
	    $require,
	],
        subscribe   => [
	    File["/etc/init.d/$serviceName"],
	    File["/etc/rc.d/rc.$serviceName"],
	    $subscribe,
	]
    }
}
