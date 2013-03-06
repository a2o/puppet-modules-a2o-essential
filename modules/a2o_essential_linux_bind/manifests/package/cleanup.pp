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



### Cleanup old versions
class   a2o_essential_linux_bind::package::cleanup   inherits   a2o_essential_linux_bind::package::base {

    $require = [
	Package['bind'],
	File['/usr/local/bind'],
	Service["$serviceName"],
    ]

    a2o-essential-unix::compiletool::package::remove { 'bind-9.8.2-1':    compileDir => $compileDir, require => $require }
    a2o-essential-unix::compiletool::package::remove { 'bind-9.9.1-1':    compileDir => $compileDir, require => $require }
}
