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



### Class for fake package, which ensures all tools are installed before this one
class   a2o_essential_linux_tools::package::tools {
    a2o-essential-unix::compiletool::fake-package { 'a2o-essential-linux-tools': }
    Class['a2o_essential_linux_tools::group::all'] -> Package['a2o-essential-linux-tools']
}
