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



### Cron: backup
class   a2o_essential_linux_mysql::cron::backup   inherits   a2o_essential_linux_mysql::base {

    cron { '/opt/scripts/mysql/dump.mysql.sh':
	user     => root,
	minute   => 30,
	hour     => 0,
	command  => "/opt/scripts/cron/run-and-mail-if-error.sh   \"/opt/scripts/mysql/dump.mysql.sh /var/backup/localhost/current/mysql\"   \"$root_email\"",
	require  => [
	    File['/opt/scripts/mysql/dump.mysql.sh'],
	    File['/opt/scripts/cron/run-and-mail-if-error.sh'],
	],
    }

    # Legacy, FIXME remove (added 2012-12-11)
    cron { '/opt/scripts/backup/dump.mysql.sh':   user => root, ensure => absent }
}
