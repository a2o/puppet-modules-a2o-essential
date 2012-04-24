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



### Base class
class   a2o-essential-redhat::base {
    $thisPuppetModule = 'a2o-essential-redhat'
}



### Final class: server
class   a2o-essential-redhat::server {
    include 'a2o-essential-unix::server'
    include 'a2o-essential-redhat::fhs'
    include 'a2o-essential-redhat::packages'
}
