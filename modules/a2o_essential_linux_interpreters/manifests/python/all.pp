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



class a2o_essential_linux_interpreters::python::all {

    Package['libs'] -> Package['python']

    include 'a2o_essential_linux_interpreters::python::package'
    include 'a2o_essential_linux_interpreters::python::module_collection'
    include 'a2o_essential_linux_interpreters::python::module_mysql'
    include 'a2o_essential_linux_interpreters::python::symlinks'
    include 'a2o_essential_linux_interpreters::python::symlinks_invasive'
}
