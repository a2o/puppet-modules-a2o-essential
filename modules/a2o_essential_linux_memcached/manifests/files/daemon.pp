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



### Runtime dirs
class   a2o_essential_linux_memcached::files::daemon_runtime   inherits   a2o_essential_linux_memcached::base {

    File {
	ensure   => directory,
        owner    => nobody,
        group    => nogroup,
        mode     => 755,
    }

    file { '/var/run/memcached':   }
}



### Config files
class   a2o_essential_linux_memcached::files::daemon_config   inherits   a2o_essential_linux_memcached::base {

    File {
        owner    => root,
        group    => root,
        mode     => 644,
#	require  => Package['memcached'],
    }

    # Directories
    file { '/etc/memcached':   ensure => directory, mode => 755 }

    # Files
    file { '/etc/memcached/memcached.config.defaults':   source => "puppet:///modules/$thisPuppetModule/memcached.config.defaults" }
}



### Files required for memcache daemon
class   a2o_essential_linux_memcached::files::daemon   inherits   a2o_essential_linux_memcached::base {

    include 'a2o_essential_linux_memcached::files::daemon_runtime'
    include 'a2o_essential_linux_memcached::files::daemon_config'
}
