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



### Files: config
class   a2o_essential_linux_keepalived::files::config   inherits   a2o_essential_linux_keepalived::base {

    File {
        owner    => root,
        group    => root,
        mode     => 644,
    }

    # Dirs
    file { '/etc/keepalived':   ensure => directory, mode => 755 }

    # Files
    file { '/etc/keepalived/keepalived.conf':   ensure => present }
}



### Include-all class for files
class   a2o_essential_linux_keepalived::files {
    include 'a2o_essential_linux_keepalived::files::config'
}
