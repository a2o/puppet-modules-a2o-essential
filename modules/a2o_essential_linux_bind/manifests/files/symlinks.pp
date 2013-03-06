
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



### Various symlinks
class   a2o_essential_linux_bind::files::symlinks   inherits   a2o_essential_linux_bind::files::base {

    File {
	ensure  => link,
	force   => false,
	require => [
	    File['/usr/local/bind'],
	],
    }

    # Configuration symlinks
    file { '/etc/named':
	target  => '/var/named/etc/named',
	require => [
	    File['/usr/local/bind'],
	    File['/var/named/etc/named'],
	],
    }
    file { '/etc/rndc.key':
	target  => '/etc/named/rndc.key',
	require => [
	    File['/usr/local/bind'],
	    File['/var/named/etc/named/rndc.key'],
	    File['/etc/named'],
	],
    }

    # Log directory symlink
    file { '/var/log/named':
	target  => '/var/named/log',
	require => [
	    File['/usr/local/bind'],
	    File['/var/named/log'],
	],
    }


    # Symlinks for programs
    file { '/usr/local/bin/dig':                target => '/usr/local/bind/bin/dig' }
    file { '/usr/local/bin/host':               target => '/usr/local/bind/bin/host' }
    file { '/usr/local/bin/nslookup':           target => '/usr/local/bind/bin/nslookup' }
    file { '/usr/local/sbin/named-checkconf':   target => '/usr/local/bind/sbin/named-checkconf' }
    file { '/usr/local/sbin/named-checkzone':   target => '/usr/local/bind/sbin/named-checkzone' }
    file { '/usr/local/sbin/rndc':              target => '/usr/local/bind/sbin/rndc' }
}
