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


    # Service init script helper files
    file { '/etc/rc.tool':                  ensure => directory }
    file { '/etc/rc.tool/common':           source => "puppet:///modules/$thisPuppetModule/rctool/common" }

    # FIXME compatibility, added on 2012-09, to be removed ASAP
    file { '/etc/rc.d/rc._functions':       ensure => '../rc.tool/common', require => File['/etc/rc.tool/common'] }

    # Wrappers
    file { '/etc/rc.tool/wrapper.debian':   source => "puppet:///modules/$thisPuppetModule/rctool/wrapper.debian" }
    file { '/etc/rc.tool/wrapper.redhat':   source => "puppet:///modules/$thisPuppetModule/rctool/wrapper.redhat" }
    file { '/etc/rc.tool/wrapper.suse':     ensure => link, target => 'wrapper.redhat' }
    file { '/etc/rc.tool/wrapper.ubuntu':   ensure => link, target => 'wrapper.debian' }
}
