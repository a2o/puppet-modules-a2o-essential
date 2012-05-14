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
	Service['a2o-linux-mysqld'],
    ]

    a2o-essential-unix::compiletool::package::remove { 'mysql-5.1.40-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'mysql-5.1.40-2': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'mysql-5.1.41-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'mysql-5.1.42-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'mysql-5.1.43-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'mysql-5.1.44-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'mysql-5.1.45-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'mysql-5.1.46-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'mysql-5.1.47-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'mysql-5.1.48-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'mysql-5.1.49-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'mysql-5.1.50-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'mysql-5.1.51-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'mysql-5.1.52-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'mysql-5.1.53-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'mysql-5.1.54-1': compileDir => $compileDir, require => $require, }
}
