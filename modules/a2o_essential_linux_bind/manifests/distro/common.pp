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



### Common resources for all distributions
class   a2o_essential_linux_bind::distro::common {

    include 'a2o_essential_linux_bind::users_groups'
    include 'a2o_essential_linux_bind::package::bind'
#    include 'a2o_essential_linux_bind::files::daemon'
#    include 'a2o_essential_linux_bind::files::helpers'
#    include 'a2o_essential_linux_bind::files::symlinks'
#    include 'a2o_essential_linux_bind::files::symlinks_log'
}
