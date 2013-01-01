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
class   a2o_essential_linux_openssh_sys::package::cleanup   inherits   a2o_essential_linux_openssh_sys::package::base {

    $require = [
	Package['openssh-sys'],
	File['/usr/local/openssh-sys'],
#	Service['a2o-linux-openssh-sys'],
    ]

    a2o-essential-unix::compiletool::package::remove { 'openssh-sys-5.5p1-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'openssh-sys-5.6p1-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'openssh-sys-5.6p1-2': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'openssh-sys-5.7p1-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'openssh-sys-5.8p1-1': compileDir => $compileDir, require => $require, }
    a2o-essential-unix::compiletool::package::remove { 'openssh-sys-5.8p1-2': compileDir => $compileDir, require => $require, }
#    a2o-essential-unix::compiletool::package::remove { 'openssh-sys-5.9p1-1': compileDir => $compileDir, require => $require, }
#    a2o-essential-unix::compiletool::package::remove { 'openssh-sys-6.1p1-1': compileDir => $compileDir, require => $require, }
#    a2o-essential-unix::compiletool::package::remove { 'openssh-sys-6.1p1-2': compileDir => $compileDir, require => $require, }
}
