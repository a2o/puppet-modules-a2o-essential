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



### RRD management scripts
class   a2o-essential-unix::scripts::rrd   inherits   a2o-essential-unix::base {

    File {
	owner => root,
	group => root,
	mode  => 755,
    }

    file { '/opt/scripts/rrd':                           ensure => directory }
    file { '/opt/scripts/rrd/fix-rrd-spikes.sh':         source => "puppet:///modules/$thisPuppetModule/scripts/rrd/fix-rrd-spikes.sh" }
    file { '/opt/scripts/rrd/rrdump.recursive.sh':       source => "puppet:///modules/$thisPuppetModule/scripts/rrd/rrdump.recursive.sh" }
    file { '/opt/scripts/rrd/rrdrestore.recursive.sh':   source => "puppet:///modules/$thisPuppetModule/scripts/rrd/rrdrestore.recursive.sh" }
}
