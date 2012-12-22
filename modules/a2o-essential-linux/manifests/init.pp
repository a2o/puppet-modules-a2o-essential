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



################################################################################
### a2o essential linux server
################################################################################

class a2o-essential-linux::server-puppetonly {
    include 'a2o-essential-unix::compiletool'
    include 'a2o-essential-linux-openssl'
    include 'a2o-essential-linux-puppet'
}

################################################################################
### END a2o essential linux server
################################################################################
