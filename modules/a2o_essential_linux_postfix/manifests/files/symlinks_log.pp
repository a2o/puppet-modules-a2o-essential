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



### Symlinks to log files
class   a2o_essential_linux_postfix::files::symlinks_log   inherits   a2o_essential_linux_postfix::base {

    # Template
    File {
	ensure   => link,
        owner    => root,
        group    => root,
        mode     => 755,
	require  => File['/usr/local/postfix'],
    }

    file { '/var/log/maillog':    target => 'postfix.log' }
    file { '/var/log/smtp.log':   target => 'postfix.log' }
}
