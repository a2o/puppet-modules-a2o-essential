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



### Daemon helpers
class   a2o_essential_linux_postfix::files::daemon::helpers   inherits   a2o_essential_linux_postfix::base {

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
    exec { 'exec /usr/bin/newaccess':       command => '/usr/bin/newaccess',     subscribe => File['/etc/postfix/access']     }
    exec { 'exec /usr/bin/newaliases':      command => '/usr/bin/newaliases',    subscribe => File['/etc/postfix/aliases']    }
    exec { 'exec /usr/bin/newrecipients':   command => '/usr/bin/newrecipients', subscribe => File['/etc/postfix/recipients'] }
    exec { 'exec /usr/bin/newsenders':      command => '/usr/bin/newsenders',    subscribe => File['/etc/postfix/senders']    }
    exec { 'exec /usr/bin/newtransport':    command => '/usr/bin/newtransport',  subscribe => File['/etc/postfix/transport']  }
    exec { 'exec /usr/bin/newvirt':         command => '/usr/bin/newvirt',       subscribe => File['/etc/postfix/virtual']    }
}
