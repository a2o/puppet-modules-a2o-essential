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



### Common config files
class   a2o_essential_linux_postfix::files::daemon::config_common   inherits   a2o_essential_linux_postfix::base {

    File {
	ensure   => present,
        owner    => root,
        group    => root,
        mode     => 644,
	require  => File['/usr/local/postfix'],
    }

    file { '/etc/postfix/header_checks':     source  => "puppet:///modules/$thisPuppetModule/header_checks" }
    file { '/etc/postfix/main.cf-local':     }
    file { '/etc/postfix/access':            }
    file { '/etc/postfix/aliases':           content => template("$thisPuppetModule/aliases") }
    file { '/etc/postfix/aliases-local':     }
    file { '/etc/postfix/senders':           }
    file { '/etc/postfix/recipients':        }
    file { '/etc/postfix/transport':         }
    file { '/etc/postfix/virtual':           }
    file { '/etc/postfix/virtual_domains':   }

    # Remove these files from installation
    file { '/etc/postfix/bounce.cf.default': ensure  => absent, }
    file { '/etc/postfix/main.cf.default':   ensure  => absent, }
}
