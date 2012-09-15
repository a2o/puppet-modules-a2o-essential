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



### Required packages
class   a2o_essential_ubuntu::packages   inherits   a2o-essential-debian::packages {

    Package {
	provider => apt,
	ensure   => present,
    }

    ### Compile utils
    package { 'diffutils':     }
    package { 'gcc':           }
    package { 'g++':           }
    package { 'libtool':       }
    package { 'make':          }
    package { 'patch':         }
    package { 'pkg-config':    }

#    package { 'zlib1g':        }   # Already defined in debian
#    package { 'zlib1g-dev':    }   # Already defined in debian

    ### Compile - Additional
    package { 'libncurses5':     }
    package { 'libncurses5-dev': }

    ### Startup tools
    package { 'chkconfig': }

    ### Compression utils
#    package { 'xz':            } # Does not exist in 12.04?

    ### Editors
    package { 'mc':            }
    package { 'nano':          }

    ### Tools - FIXME migrate to a2o_essential_ubuntu_tools?
    package { 'librrd-dev':    }
    package { 'rrdtool':       }
    Package['librrd-dev'] -> Package['rrdtool']
}
