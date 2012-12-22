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



### Software package: ruby
class   a2o_essential_linux_interpreters::ruby::symlinks   inherits   a2o_essential_linux_interpreters::ruby::base {

    File {
	require  => File['/usr/local/ruby'],
	backup   => false,
    }

    # Program symlinks
    file { '/usr/bin/ruby':                    ensure => '/usr/local/bin/ruby',                 }
    file { '/usr/local/bin/ruby':              ensure => '/usr/local/ruby/bin/ruby',            }
    file { '/usr/local/bin/irb':               ensure => '/usr/local/ruby/bin/irb',             }
    file { '/usr/local/bin/rake':              ensure => '/usr/local/ruby/bin/rake',            }
    file { '/usr/local/bin/cap':               ensure => '/usr/local/ruby/bin/cap',             }
    file { '/usr/local/bin/capify':            ensure => '/usr/local/ruby/bin/capify',          }
    file { '/usr/local/bin/unicorn':           ensure => '/usr/local/ruby/bin/unicorn',         }
    file { '/usr/local/bin/unicorn_rails':     ensure => '/usr/local/ruby/bin/unicorn_rails',   }

    # TODO - remove these
#    file { '/usr/local/bin/mongrel_cluster':       ensure => absent, }
#    file { '/usr/local/bin/mongrel_cluster_ctl':   ensure => absent, }
#    file { '/usr/local/bin/mongrel_rails':         ensure => absent, }
}
