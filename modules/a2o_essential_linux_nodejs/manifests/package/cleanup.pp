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
class   a2o_essential_linux_nodejs::package::cleanup   inherits   a2o_essential_linux_nodejs::package::base {

    $require = [
	Package['nodejs'],
	File['/usr/local/nodejs'],
    ]

#    a2o-essential-unix::compiletool::package::remove { 'nodejs-0.8.5-1': compileDir => $compileDir, require => $require, }
}
