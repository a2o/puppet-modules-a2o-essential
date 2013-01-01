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



class a2o_essential_linux_libs::group::ganglia_gmond_redhat {
    include 'a2o-essential-linux-libs::apr'
    include 'a2o-essential-linux-libs::apr-util'
    include 'a2o-essential-linux-libs::confuse'
    include 'a2o-essential-linux-libs::expat'
#    include 'a2o-essential-linux-libs::pcre'
}