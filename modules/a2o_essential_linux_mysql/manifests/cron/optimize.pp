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



### Cron: optimize
class   a2o_essential_linux_mysql::cron::optimize   inherits   a2o_essential_linux_mysql::base {

    cron { '/opt/scripts/mysql/optimize-all-tables.sh':
	user     => root,
	minute   => 0,
	hour     => 4,
	weekday  => 2,
	command  => "/opt/scripts/cron/run-and-mail-if-error.sh   \"/opt/scripts/mysql/optimize-all-tables.sh\"   \"$root_email\"",
	require  => [
	    File['/opt/scripts/mysql/optimize-all-tables.sh'],
	    File['/opt/scripts/cron/run-and-mail-if-error.sh'],
	],
    }
}
