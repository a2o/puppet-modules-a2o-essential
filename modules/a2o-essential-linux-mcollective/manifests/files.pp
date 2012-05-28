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



### Some configuration files
class   a2o-essential-linux-mcollective::files   inherits   a2o-essential-linux-mcollective::base {

    File {
	owner => root,
	group => root,
    }

    file { '/etc/mcollective':                     mode => 700, ensure => directory }
    file { '/etc/mcollective/facts-generate.sh':   mode => 700, source => "puppet:///modules/$thisPuppetModule/facts-generate.sh" }
}
