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
class   a2o_essential_linux_openssh_sys::files::symlinks   inherits   a2o_essential_linux_openssh_sys::base {

    # Template
    File {
        require  => File['/usr/local/ssh-sys'],
        owner    => root,
        group    => root,
        mode     => 0755,
        backup   => true,
    }

    # 'Symlinks'
    file { '/usr/local/bin/ssh-sys':   content => '/usr/local/ssh-sys/bin/ssh -p10022 $@' }
    file { '/usr/local/bin/scp-sys':   content => '/usr/local/ssh-sys/bin/scp -P10022 $@' }
}
