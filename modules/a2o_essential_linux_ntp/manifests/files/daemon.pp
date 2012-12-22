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
class   a2o_essential_linux_ntp::files::daemon_runtime   inherits   a2o_essential_linux_ntp::base {

    File {
	ensure   => directory,
        owner    => root,
        group    => root,
        mode     => 755,
    }
    file { '/var/ntp':   }
}



### Config files
class   a2o_essential_linux_ntp::files::daemon_config   inherits   a2o_essential_linux_ntp::base {

    File {
        owner    => root,
        group    => root,
        mode     => 644,
    }
    file { '/etc/ntp.conf':   source => "puppet:///modules/$thisPuppetModule/ntp.conf" }
}



### Files required for ntp daemon
class   a2o_essential_linux_ntp::files::daemon   inherits   a2o_essential_linux_ntp::base {
    include 'a2o_essential_linux_ntp::files::daemon_runtime'
    include 'a2o_essential_linux_ntp::files::daemon_config'
}
