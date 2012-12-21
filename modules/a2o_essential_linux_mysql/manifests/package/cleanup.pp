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
class   a2o_essential_linux_mysql::package::cleanup   inherits   a2o_essential_linux_mysql::package::base {

    $require = [
	Package['mysql'],
	File['/usr/local/mysql'],
    ]

    a2o-essential-unix::compiletool::package::remove { 'mysql-5.1.58-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'mysql-5.1.59-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'mysql-5.1.60-1': compileDir => $compileDir, require => $require, }
#    a2o-essential-unix::compiletool::package::remove { 'mysql-5.1.61-1': compileDir => $compileDir, require => $require, }
#    a2o-essential-unix::compiletool::package::remove { 'mysql-5.1.62-1': compileDir => $compileDir, require => $require, }
#    a2o-essential-unix::compiletool::package::remove { 'mysql-5.1.63-1': compileDir => $compileDir, require => $require, }
#    a2o-essential-unix::compiletool::package::remove { 'mysql-5.1.65-1': compileDir => $compileDir, require => $require, }
#    a2o-essential-unix::compiletool::package::remove { 'mysql-5.1.66-1': compileDir => $compileDir, require => $require, }
}
