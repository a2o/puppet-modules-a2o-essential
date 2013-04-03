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



### a2o basic
class   a2o-essential-unix::scripts::a2o   inherits   a2o-essential-unix::base {

    File {
	owner => root,
	group => root,
    }

    file { '/opt/scripts/a2o':                      ensure => directory }
    file { '/opt/scripts/a2o/script-framework':     source => "puppet:///modules/$thisPuppetModule/scripts/a2o/script-framework" }
}
