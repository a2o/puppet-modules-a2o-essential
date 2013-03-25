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



### Common config files
class   a2o_essential_linux_postfix::files::daemon::config_specific_pa   inherits   a2o_essential_linux_postfix::base {

    File {
	ensure   => present,
        owner    => root,
        group    => root,
        mode     => 644,
	require  => File['/usr/local/postfix'],
    }

    # Main config files
    file { '/etc/postfix/master.cf':         content => template("$thisPuppetModule/master.cf",      "$thisPuppetModule/master.cf-additional4pa")      }
    file { '/etc/postfix/main.cf-global':    content => template("$thisPuppetModule/main.cf-global", "$thisPuppetModule/main.cf-global-additional4pa") }

    # MySQL configuration files
    file { '/etc/postfix/mysql_relay_domains.cf':                content => template("$thisPuppetModule/mysql_relay_domains.cf"),              group => postfix, mode => 640 }
    file { '/etc/postfix/mysql_virtual_alias_maps.cf':           content => template("$thisPuppetModule/mysql_virtual_alias_maps.cf"),         group => postfix, mode => 640 }
    file { '/etc/postfix/mysql_virtual_alias_alias_maps.cf':     content => template("$thisPuppetModule/mysql_virtual_alias_alias_maps.cf"),   group => postfix, mode => 640 }
    file { '/etc/postfix/mysql_virtual_domain_maps.cf':          content => template("$thisPuppetModule/mysql_virtual_domain_maps.cf"),        group => postfix, mode => 640 }
    file { '/etc/postfix/mysql_virtual_mailbox_maps.cf':         content => template("$thisPuppetModule/mysql_virtual_mailbox_maps.cf"),       group => postfix, mode => 640 }
    file { '/etc/postfix/mysql_virtual_mailbox_alias_maps.cf':   content => template("$thisPuppetModule/mysql_virtual_mailbox_alias_maps.cf"), group => postfix, mode => 640 }
    file { '/etc/postfix/mysql_virtual_mailbox_limit_maps.cf':   content => template("$thisPuppetModule/mysql_virtual_mailbox_limit_maps.cf"), group => postfix, mode => 640 }

    # Virtual mail location
    file { '/var/mail/virtual':   ensure => directory, mode => 755, owner => 9997,    group => 9997,     }

    # Vacation script and transport entry
    file { '/var/postfix/vacation/vacation.pl':
	content => template("$thisPuppetModule/vacation.pl"),
	owner   => vacation, group => vacation, mode => 700,
    }
    line_in_file { '/etc/postfix/transport autoreply.local':
        ensure       => present,
	file         => '/etc/postfix/transport',
	line_regex   => 'autoreply.local[[:space:]]+vacation:[[:space:]]*',
	line         => 'autoreply.local   vacation:',
	remove_regex => 'autoreply.local[[:space:]]+vacation:[[:space:]]*',
	require      => [
	    File['/etc/postfix/transport'],
	],
    }
    Line_in_file['/etc/postfix/transport autoreply.local'] ~> Exec['exec /usr/bin/newtransport']
}
