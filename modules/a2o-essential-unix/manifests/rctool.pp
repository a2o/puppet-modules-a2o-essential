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



### RCtool for service management
class a2o-essential-unix::rctool inherits a2o-essential-unix::base {

    File {
        owner   => root,
        group   => root,
        mode    => 755,
    }


    # Service init script helper libraries
    file { '/etc/rc.d/rc._functions':   source => "puppet:///modules/$thisPuppetModule/rctool/rc._functions", }
}
