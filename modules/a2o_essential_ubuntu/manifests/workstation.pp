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



### Final class: server
class a2o_essential_ubuntu::workstation {
#    include 'a2o-essential-unix::server'
#    include 'a2o_essential_ubuntu::fhs'
#    include 'a2o_essential_ubuntu::sys'
    include 'a2o_essential_ubuntu::packages::workstation'
}
