
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



### Daemon configuration and runtime directories
class   a2o_essential_linux_bind::files::daemon::dirs   inherits   a2o_essential_linux_bind::files::base {

    File {
	ensure => directory,
	mode   => 755,
    }

    file { '/var/named':                          owner => named, group => named }
    file { '/var/named/dev':                      }
    file { '/var/named/etc':                      }
    file { '/var/named/etc/named':                }
    file { '/var/named/etc/named/managed-keys':   }   # This is a dummy workaround
    file { '/var/named/log':                      owner => named, group => named }
    file { '/var/named/run':                      owner => named, group => named }
    file { '/var/named/var':                      }

    file { '/var/named/zones':                    }
    file { '/var/named/zones/master':             }
    file { '/var/named/zones/slave':              owner => named, group => named }
    file { '/var/named/zones/dynamic':            owner => named, group => named }

    # Loop symlink for chrooted environment
    file { '/var/named/var/named':
	ensure  => link,
	target  => '..',
	require => File['/var/named/var'],
    }
}


### Daemon configuration files
class   a2o_essential_linux_bind::files::daemon::files   inherits   a2o_essential_linux_bind::files::base {

    File {
	ensure => present,
	mode   => 644,
    }

    # Main config file
    file { '/var/named/etc/named/named.conf':
	content  => template("$thisPuppetModule/named.conf"),
    }
    file { '/var/named/etc/named/rndc.key':
        ensure   => present,
        owner    => root,
        group    => named,
        mode     => 640,
	notify   => Exec['rndc-confgen /var/named/etc/named/rndc.key'],
    }
    exec { 'rndc-confgen /var/named/etc/named/rndc.key':
	subscribe   => File['/var/named/etc/named/rndc.key'],
	command     => '/usr/local/bind/sbin/rndc-confgen -a -b512 -k rndc-key -r /dev/urandom -c /var/named/etc/named/rndc.key',
	onlyif      => 'test ! -s /var/named/etc/named/rndc.key',
	environment => "LD_LIBRARY_PATH=/usr/local/openssl/lib",
    }

    # Dummy workaround
    file { '/var/named/etc/named/managed-keys/managed-keys.bind':   ensure => present }

    # Then zone config files
    file { '/var/named/zone.list':   }

    # Basic zones
    file { '/var/named/zones/127.0.0':      source => "puppet:///modules/$thisPuppetModule/127.0.0",    }
    file { '/var/named/zones/localhost':    source => "puppet:///modules/$thisPuppetModule/localhost",  }
    file { '/var/named/zones/root.hints':   source => "puppet:///modules/$thisPuppetModule/root.hints", }
}



### Final daemon files class
class   a2o_essential_linux_bind::files::daemon {
    include 'a2o_essential_linux_bind::files::daemon::dirs'
    include 'a2o_essential_linux_bind::files::daemon::files'
}
