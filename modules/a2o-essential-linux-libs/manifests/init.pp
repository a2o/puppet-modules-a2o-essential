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
# Authors: Bostjan Skufca <bostjan@a2o.si>                                #
###########################################################################



### Base class
class a2o-basic-linux-libs::base {
    $thisPuppetModule = "a2o-basic-linux-libs"

    # External packages
    $externalPackageDestdir_openssl = '/usr/local/openssl-1.0.0g-1'

    # Where the packages will be compiled
    $compileDir = '/var/src/libs'
}



### Final all-containing class
class a2o-basic-linux-libs {
    include 'a2o-basic-linux-libs::confuse'
}
