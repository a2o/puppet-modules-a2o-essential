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
class   a2o_essential_linux_openssh::package::cleanup   inherits   a2o_essential_linux_openssh::package::base {

    $require = [
	Package['openssh'],
	File['/usr/local/openssh'],
#	Service['a2o-linux-openssh'],
    ]

    a2o-essential-unix::compiletool::package::remove { 'openssh-5.5p1-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'openssh-5.6p1-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'openssh-5.6p1-2': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'openssh-5.7p1-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'openssh-5.8p1-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'openssh-5.8p1-2': compileDir => $compileDir, require => $require, }
#    a2o-essential-unix::compiletool::package::remove { 'openssh-5.9p1-1': compileDir => $compileDir, require => $require, }
#    a2o-essential-unix::compiletool::package::remove { 'openssh-5.9p1-2': compileDir => $compileDir, require => $require, }
}
