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



### Software package: python
class   a2o_essential_linux_interpreters::python::symlinks   inherits   a2o_essential_linux_interpreters::python::base {

    File {
	require  => File['/usr/local/python'],
	backup   => false,
    }


    # Program symlinks
    file { '/usr/local/bin/python':      ensure => '/usr/local/python/bin/python',    }
    file { '/usr/local/bin/python2.6':   ensure => '/usr/local/python-2.6/bin/python2.6', }
    file { '/usr/local/bin/python2.7':   ensure => '/usr/local/python-2.7/bin/python2.7', }
}
