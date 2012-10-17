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



### a2o-specific config files
class   a2o_essential_linux_collectd::files::daemon_a2o   inherits   a2o_essential_linux_collectd::base {

    File {
        owner    => root,
        group    => root,
        mode     => 644,
    }

    file { '/etc/collectd.d/a2o_additional.conf':   content => template("$thisPuppetModule/a2o_additional.conf") }
    File['/etc/collectd.d/a2o_additional.conf'] ~> Service['a2o-essential-collectd']

    # FIXME remove, added at on 2012-10-17
    file { '/etc/collectd.d/a2o_filecount.conf':    ensure  => absent }
}
