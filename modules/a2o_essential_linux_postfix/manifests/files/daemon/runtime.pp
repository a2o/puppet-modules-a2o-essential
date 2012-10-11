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



### Runtime dirs
class   a2o_essential_linux_postfix::files::daemon::runtime   inherits   a2o_essential_linux_postfix::base {

    File {
	ensure   => directory,
        owner    => root,
        group    => root,
        mode     => 755,
        require  => [
	    File['/usr/local/postfix'],
	],
    }

    file { '/etc/postfix':                  }
    file { '/etc/mail':                     ensure => link, target => 'postfix' }
    file { '/var/postfix':                  }
    file { '/var/postfix/spool':            }
    file { '/var/postfix/queue':            ensure => link, target => 'spool' }
    file { '/var/postfix/spool/maildrop':   mode => 730, owner => postfix, group => postdrop }
}
