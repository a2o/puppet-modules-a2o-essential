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



### Service base class: postfix
class   a2o_essential_linux_postfix::distro::service_base_nopa   inherits   a2o_essential_linux_postfix::distro::service_base_common {

    $destDir_openssl = $a2o_essential_linux_postfix::package::postfix::destDir_openssl

    $require   = [
	$requireCommon,
    ]

    $subscribe = [
	$subscribeCommon,
	Package['postfix'],
    ]
}
