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



### Software package: slocate
class   a2o-essential-linux-tools::slocate   inherits   a2o-essential-linux-tools::base {

    # Removal: Superseeded by mlocate, remove old stuff now
    # This removal was added 2012-09-01
    File {
	ensure => absent,
    }

    file { '/usr/local/bin/slocate':        }
    file { '/var/lib/slocate/slocate.db':   }
    file { '/var/lib/slocate':              require => File['/var/lib/slocate/slocate.db'] }
}
