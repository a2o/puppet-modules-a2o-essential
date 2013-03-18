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
class   a2o_essential_linux_interpreters::python::symlinks_invasive   inherits   a2o_essential_linux_interpreters::python::base {

    File {
	require  => File['/usr/local/python'],
	backup   => false,
    }


    # Program symlinks
    file { '/usr/bin/python':            ensure => '/usr/local/bin/python' }


    # Library symlinks
    file { '/usr/local/lib/libpython2.6.so':       ensure => '/usr/local/python-2.6/lib/libpython2.6.so'     }
    file { '/usr/local/lib/libpython2.6.so.1.0':   ensure => '/usr/local/python-2.6/lib/libpython2.6.so.1.0' }
    file { '/usr/local/lib/libpython2.7.so':       ensure => '/usr/local/python-2.7/lib/libpython2.7.so'     }
    file { '/usr/local/lib/libpython2.7.so.1.0':   ensure => '/usr/local/python-2.7/lib/libpython2.7.so.1.0' }

    exec { 'exec sbin ldconfig libpython2.6.so':
        command     => '/sbin/ldconfig',
        subscribe   => File['/usr/local/lib/libpython2.6.so'],
        refreshonly => true,
    }
    exec { 'exec sbin ldconfig libpython2.6.so.1.0':
        command     => '/sbin/ldconfig',
        subscribe   => File['/usr/local/lib/libpython2.6.so.1.0'],
        refreshonly => true,
    }
    exec { 'exec sbin ldconfig libpython2.7.so':
        command     => '/sbin/ldconfig',
        subscribe   => File['/usr/local/lib/libpython2.7.so'],
        refreshonly => true,
    }
    exec { 'exec sbin ldconfig libpython2.7.so.1.0':
        command     => '/sbin/ldconfig',
        subscribe   => File['/usr/local/lib/libpython2.7.so.1.0'],
        refreshonly => true,
    }
}
