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



### Remove old packages
class   a2o_essential_linux_collectd::package::cleanup   inherits   a2o_essential_linux_collectd::package::base {

    $serviceName = $operatingsystem ? {
	'slackware' => 'a2o-linux-collectd',
	default     => 'collectd',
    }
    $require = [
	Package['collectd'],
	File['/usr/local/collectd'],
	Service["$serviceName"],
    ]

    a2o-essential-unix::compiletool::package::remove { 'collectd-5.0.3-1': compileDir => $compileDir, require => $require }
    a2o-essential-unix::compiletool::package::remove { 'collectd-5.0.4-1': compileDir => $compileDir, require => $require }
    a2o-essential-unix::compiletool::package::remove { 'collectd-5.0.4-2': compileDir => $compileDir, require => $require }
}
