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



### Program symlinks
class   a2o_essential_linux_openssh::symlinks   inherits   a2o_essential_linux_openssh::base {

    # Template
    File {
        owner   => root,
        group   => root,
        mode    => 755,
	require => File['/usr/local/ssh'],
    }

    file { '/usr/local/bin/scp':           ensure => '/usr/local/ssh/bin/scp'         }
    file { '/usr/local/bin/sftp':          ensure => '/usr/local/ssh/bin/sftp'        }
    file { '/usr/local/bin/ssh':           ensure => '/usr/local/ssh/bin/ssh'         }
    file { '/usr/local/bin/ssh-keygen':    ensure => '/usr/local/ssh/bin/ssh-keygen'  }
    file { '/usr/local/bin/ssh-keyscan':   ensure => '/usr/local/ssh/bin/ssh-keyscan' }
}
