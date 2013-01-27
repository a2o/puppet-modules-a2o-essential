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



### NTP time sync
class   a2o-essential-redhat::sys::ntp   inherits   a2o-essential-redhat::base {

#    ### NTP config file
#    File {
#        owner    => root,
#        group    => root,
#        mode     => 755,
#    }
#    file { '/etc/ntp.conf':   source => "puppet:///modules/$thisPuppetModule/ntp.conf" }

    a2o-essential-redhat::service::generic { 'ntpd': }
}



### SElinux
class   a2o-essential-redhat::sys::selinux_disable   inherits   a2o-essential-redhat::base {

    File {
        owner    => root,
        group    => root,
        mode     => 644,
    }
    file { '/etc/selinux/config':   source => "puppet:///modules/$thisPuppetModule/selinux/config" }
}



### Obligatory stuff for all servers
class   a2o-essential-redhat::sys {
    include 'a2o-essential-redhat::sys::ntp'
    include 'a2o-essential-redhat::sys::selinux_disable'
}
