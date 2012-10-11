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
class   a2o_essential_linux_postfix::distro::specific_nopa {

    include 'a2o_essential_linux_postfix::users_groups'
    include 'a2o_essential_linux_postfix::package::postfix'
    include 'a2o_essential_linux_postfix::files::daemon'
}
