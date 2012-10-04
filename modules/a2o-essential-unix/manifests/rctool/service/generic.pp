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



### Generic service definition
#
# This is used as a template for service definitions in other modules
# Pass it the service name, require and subscribe definitions and it will generate
# service resource for you.

define   a2o-essential-unix::rctool::service::generic   ($ensure='running', $require=[], $subscribe=[]) {


    ###
    ### Configuration
    ###
    $serviceName   = "$name"
    $serviceEnsure = "$ensure"


    ###
    ### Startup file definition
    ###
    file { "/etc/rc.d/rc.$serviceName":
        content  => template("$thisPuppetModule/rc.$serviceName"),
        owner    => root,
        group    => root,
	require  => [
    	    File['/etc/rc.tool/common'],
            $require,
	],
    }


    ###
    ### Service definition
    ###
    service { "a2o-linux-$serviceName":
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
	provider    => 'a2o_linux_rctool',
        require     => [
	    $require,
	],
        subscribe   => [
    	    File["/etc/rc.d/rc.$serviceName"],
	    $subscribe,
	]
    }
}
