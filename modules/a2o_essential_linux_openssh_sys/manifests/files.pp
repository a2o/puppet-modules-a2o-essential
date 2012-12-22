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
class   a2o_essential_linux_openssh_sys::files   inherits   a2o_essential_linux_openssh_sys::base {

    # Template
    File {
        owner    => root,
        group    => root,
        mode    => 644,
    }

    # Configuration directory and files
    file { '/etc/ssh-sys':
        ensure  => directory,
        mode    => 755,
    }
    file { '/etc/ssh-sys/ssh_config':    source => "puppet:///modules/$thisPuppetModule/ssh_config", }
    file { '/etc/ssh-sys/sshd_config':   source => "puppet:///modules/$thisPuppetModule/sshd_config", }
}
