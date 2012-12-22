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



### Base class
class a2o-essential-linux-tools::base {
    $thisPuppetModule = "a2o-essential-linux-tools"

    # Where the packages will be compiled
    $compileDir = '/var/src/tools'
}



### Final all-containing class - FIXME legacy, remove ASAP, like this since 2012-10-10
class a2o-essential-linux-tools {
    include 'a2o_essential_linux_tools'
}
