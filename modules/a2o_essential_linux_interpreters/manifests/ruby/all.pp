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



class a2o_essential_linux_interpreters::ruby::all {

    Package['libs'] -> Package['ruby']

    include 'a2o_essential_linux_interpreters::ruby::package'
    include 'a2o_essential_linux_interpreters::ruby::gem_collection'
    include 'a2o_essential_linux_interpreters::ruby::gem_mysql'
    include 'a2o_essential_linux_interpreters::ruby::gem_postgresql'
    include 'a2o_essential_linux_interpreters::ruby::gem_rmagick'
    include 'a2o_essential_linux_interpreters::ruby::symlinks'
}
