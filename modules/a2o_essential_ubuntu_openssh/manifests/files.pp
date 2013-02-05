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



### Configuration files
class   a2o_essential_ubuntu_openssh::files   inherits   a2o_essential_ubuntu_openssh::base {

    # Template
    File {
        owner   => root,
        group   => root,
        mode    => 644,
    }

    # Configuration directory and files
    file { '/etc/ssh':
        ensure  => directory,
        mode    => 755,
    }
#    file { '/etc/ssh/ssh_config':    source => "puppet:///modules/$thisPuppetModule/ssh_config"  }
    file { '/etc/ssh/sshd_config':   source => "puppet:///modules/$thisPuppetModule/sshd_config" }
}
