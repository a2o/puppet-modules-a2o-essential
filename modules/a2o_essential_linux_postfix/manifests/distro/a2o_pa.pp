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



### Service: postfix
class   a2o_essential_linux_postfix::distro::a2o_pa::service   inherits   a2o_essential_linux_postfix::distro::service_base_pa {

    a2o-essential-unix::rctool::service::generic { 'postfix':
        require    => $require,
        subscribe  => $subscribe,
#	rcTemplate => "$thisPuppetModule/rc.postfix-pa",
    }
}



### Final all-containing class
class   a2o_essential_linux_postfix::distro::a2o_pa {
    include 'a2o_essential_linux_postfix::distro::common'
    include 'a2o_essential_linux_postfix::distro::specific_pa'
    include 'a2o_essential_linux_postfix::distro::a2o_pa::service'
}
