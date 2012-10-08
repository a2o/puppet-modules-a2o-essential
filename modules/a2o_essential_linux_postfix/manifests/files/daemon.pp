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
class   a2o_essential_linux_postfix::files::daemon_runtime   inherits   a2o_essential_linux_postfix::base {

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



### Config files
class   a2o_essential_linux_postfix::files::daemon_config   inherits   a2o_essential_linux_postfix::base {

    File {
	ensure   => present,
        owner    => root,
        group    => root,
        mode     => 644,
	require  => File['/usr/local/postfix'],
    }

    file { '/etc/postfix/master.cf':         source  => "puppet:///modules/$thisPuppetModule/master.cf"     }
    file { '/etc/postfix/header_checks':     source  => "puppet:///modules/$thisPuppetModule/header_checks" }
    file { '/etc/postfix/main.cf-global':    content => template("$thisPuppetModule/main.cf-global")        }
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



### Config files
class   a2o_essential_linux_postfix::files::daemon_helpers   inherits   a2o_essential_linux_postfix::base {

    File {
	ensure   => present,
        owner    => root,
        group    => root,
        mode     => 755,
	require  => File['/usr/local/postfix'],
    }
    file { '/usr/bin/newaccess':       source => "puppet:///modules/$thisPuppetModule/newaccess"     }
    file { '/usr/bin/newsenders':      source => "puppet:///modules/$thisPuppetModule/newsenders"    }
    file { '/usr/bin/newrecipients':   source => "puppet:///modules/$thisPuppetModule/newrecipients" }
    file { '/usr/bin/newtransport':    source => "puppet:///modules/$thisPuppetModule/newtransport"  }
    file { '/usr/bin/newvirt':         source => "puppet:///modules/$thisPuppetModule/newvirt"       }

    Exec {
        refreshonly => true,
	require     => File['/usr/local/postfix'],
    }
    exec { 'exec usr bin newaccess':       command => '/usr/bin/newaccess',     subscribe => File['/etc/postfix/access']     }
    exec { 'exec usr bin newaliases':      command => '/usr/bin/newaliases',    subscribe => File['/etc/postfix/aliases']    }
    exec { 'exec usr bin newrecipients':   command => '/usr/bin/newrecipients', subscribe => File['/etc/postfix/recipients'] }
    exec { 'exec usr bin newsenders':      command => '/usr/bin/newsenders',    subscribe => File['/etc/postfix/senders']    }
    exec { 'exec usr bin newtransport':    command => '/usr/bin/newtransport',  subscribe => File['/etc/postfix/transport']  }
    exec { 'exec usr bin newvirt':         command => '/usr/bin/newvirt',       subscribe => File['/etc/postfix/virtual']    }
}



### Files required for postfix daemon
class   a2o_essential_linux_postfix::files::daemon {

    include 'a2o_essential_linux_postfix::files::daemon_runtime'
    include 'a2o_essential_linux_postfix::files::daemon_config'
    include 'a2o_essential_linux_postfix::files::daemon_helpers'
}
