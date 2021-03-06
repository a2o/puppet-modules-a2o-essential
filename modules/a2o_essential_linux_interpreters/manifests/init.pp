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
class a2o_essential_linux_interpreters::base {
    $thisPuppetModule = 'a2o_essential_linux_interpreters'


    # Where the packages will be compiled
    $compileDir = "/var/src/interpreters"


    # External software versions
    $externalDestDir_openssl   = '/usr/local/openssl-1.0.0h-1'
}



### All-containing class
class a2o_essential_linux_interpreters {
#    include 'a2o_essential_linux_interpreters::perl'
#    include 'a2o_essential_linux_interpreters::php'
    include 'a2o_essential_linux_interpreters::python'
#    include 'a2o_essential_linux_interpreters::ruby'
}
