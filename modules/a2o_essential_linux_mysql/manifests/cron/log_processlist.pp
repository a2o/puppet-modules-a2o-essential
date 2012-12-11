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



### Cron: log_processlist
class   a2o_essential_linux_mysql::cron::log_processlist   inherits   a2o_essential_linux_mysql::base {

    cron { '/opt/scripts/mysql/log_processlist.sh':
	user     => root,
	command  => "/opt/scripts/cron/run-and-mail-if-error.sh   \"/opt/scripts/mysql/log_processlist.sh\"   \"$root_email\"",
	require  => [
	    File['/opt/scripts/mysql/log_processlist.sh'],
	    Service['a2o-linux-mysqld'],
	    File['/usr/local/bin/mysql'],
	    File['/var/mysql/log/processlist_logs'],
	],
    }
}
