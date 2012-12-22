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



### Helper files
class   a2o_essential_linux_collectd::files::helpers   inherits   a2o_essential_linux_collectd::base {

    # Template
    File {
        owner    => root,
        group    => root,
        mode     => 755,
    }

    # Helper files
    file { '/opt/scripts/collectd':   ensure => directory }
    file { '/opt/scripts/collectd/mysql-fix-COUNTER-to-DERIVE.sh':   source => "puppet:///modules/$thisPuppetModule/mysql-fix-COUNTER-to-DERIVE.sh" }
}
