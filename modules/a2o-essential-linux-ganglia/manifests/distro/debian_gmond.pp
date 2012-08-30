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



### Service: gmond FIXME change to debian native statup - upstart?
class   a2o-essential-linux-ganglia::distro::debian_gmond::service   inherits   a2o-essential-linux-ganglia::distro::suse-gmond::base {

    $require   = [
    ]

    $subscribe = [
	Package['ganglia-gmond'],
	File['/etc/ganglia/gmond.conf'],
	File['/etc/ganglia/conf.d/modpython.conf'],
	File['/etc/ganglia/conf.d/a2o'],
	File['/etc/ganglia/python_modules'],
	User['ganglia'],
	Group['ganglia'],
    ]

    a2o-essential-unix::rctool::service::generic { 'gmond':
        require   => $require,
        subscribe => $subscribe,
    }
}



### The final all-containing classes
class a2o-essential-linux-ganglia::distro::debian_gmond {
    include 'a2o-essential-linux-ganglia::users'
    include 'a2o-essential-linux-ganglia::package::gmond'
    include 'a2o-essential-linux-ganglia::files'
    include 'a2o-essential-linux-ganglia::files::gmond'
    include 'a2o-essential-linux-ganglia::distro::debian_gmond::service'
}
