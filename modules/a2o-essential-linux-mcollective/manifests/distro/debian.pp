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
class   a2o-essential-linux-mcollective::distro::debian::base   inherits a2o-essential-linux-mcollective::base {
}



### Service: mcollectived
class   a2o-essential-linux-mcollective::distro::debian::service   inherits   a2o-essential-linux-mcollective::distro::debian::base {


    ### Requires and subscribes
    $require   = []
    $subscribe = [
	Package['ruby'],
        File['/usr/local/ruby'],
	Package['mcollective'],
        File['/usr/local/mcollective'],
        File['/etc/mcollective/server.cfg'],
        File['/etc/mcollective/facts-generate.sh'],
    ]

    ### Instantiate from template
    a2o-essential-debian::service::generic_withstartupfile { 'mcollectived':
	require   => $require,
	subscribe => $subscribe,
    }
}



### The final all-containing classes
class a2o-essential-linux-mcollective::distro::debian {
    include 'a2o-essential-linux-mcollective::package'
    include 'a2o-essential-linux-mcollective::files'
    include 'a2o-essential-linux-mcollective::distro::debian::service'
}
