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



### Runtime dirs
class   a2o_essential_linux_collectd::files::daemon_runtime   inherits   a2o_essential_linux_collectd::base {

    File {
	ensure   => directory,
        owner    => root,
        group    => root,
        mode     => 755,
    }

    file { '/var/collectd':   }
}



### Config files
class   a2o_essential_linux_collectd::files::daemon_config   inherits   a2o_essential_linux_collectd::base {

    File {
        owner    => root,
        group    => root,
        mode     => 644,
    }

    # Directories
    file { '/etc/collectd.d':   ensure => directory, mode => 755 }

    # Files
    file { '/etc/collectd.conf':                 content => template("$thisPuppetModule/collectd.conf") }
    file { '/etc/collectd.d/PLACEHOLDER.conf':   content => "# Dont remove this file, or collectd will squeal!\n" }
}



### Files required for collectd daemon
class   a2o_essential_linux_collectd::files::daemon   inherits   a2o_essential_linux_collectd::base {

    include 'a2o_essential_linux_collectd::files::daemon_runtime'
    include 'a2o_essential_linux_collectd::files::daemon_config'
}
