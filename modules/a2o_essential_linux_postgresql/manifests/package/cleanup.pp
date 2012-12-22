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
class   a2o_essential_linux_postgresql::package::cleanup   inherits   a2o_essential_linux_postgresql::package::base {

    $require = [
	Package['postgresql'],
	File['/usr/local/postgresql'],
	Service['a2o-linux-postgresqld'],
    ]

#    a2o-essential-unix::compiletool::package::remove { 'postgresql-9.1.4-1': compileDir => $compileDir, require => $require, }
}
