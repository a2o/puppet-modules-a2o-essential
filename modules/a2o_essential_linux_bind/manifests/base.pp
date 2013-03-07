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
class   a2o_essential_linux_bind::base
(
    $thisPuppetModule = a2o_get_current_module_name(),

    $acl_recursion    = a2o_get_param('acl_recursion'),
    $acl_transfer     = a2o_get_param('acl_transfer'),

    $forwarders       = a2o_get_param('forwarders'),

    $fakeLastParamWithNoTailingComma = ''
)
inherits   a2o_essential_linux_bind::params {}
