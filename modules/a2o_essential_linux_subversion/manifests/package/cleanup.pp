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



### Remove old packages
class   a2o_essential_linux_subversion::package::cleanup   inherits   a2o_essential_linux_subversion::package::base {

    $require = [
	Package['svn'],
	File['/usr/local/svn'],
    ]

    a2o-essential-unix::compiletool::package::remove { 'svn-1.7.2-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'svn-1.7.3-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'svn-1.7.4-1': compileDir => $compileDir, require => $require, }
}
