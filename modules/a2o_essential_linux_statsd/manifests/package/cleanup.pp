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



### Remove old packages
class   a2o_essential_linux_statsd::package::cleanup   inherits   a2o_essential_linux_statsd::package::base {

    $require = [
	Package['statsd'],
	File['/usr/local/statsd'],
    ]

#    a2o-essential-unix::compiletool::package::remove { 'statsd-0.5.0-1': compileDir => $compileDir, require => $require, }
}
