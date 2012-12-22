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



### Base class for service gmond
class   a2o-essential-linux-ganglia::distro::base_gmond   inherits   a2o-essential-linux-ganglia::base {

    $require   = [
    ]

    $subscribe = [
        Package['ganglia-gmond'],
        File['/usr/local/ganglia-gmond'],
	File['/etc/ganglia/gmond.conf'],
	File['/etc/ganglia/conf.d/modpython.conf'],
	File['/etc/ganglia/conf.d/a2o'],
	File['/etc/ganglia/python_modules'],
	User['ganglia'],
	Group['ganglia'],
    ]
}
