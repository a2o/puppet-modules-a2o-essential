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



### Required packages
class   a2o-essential-debian::packages   inherits   a2o-essential-debian::base {

    Package {
	provider => apt,
	ensure   => present,
    }

    # Build tools
#    package { 'diff':          }
#    package { 'gcc':           }
#    package { 'g++':           }
#    package { 'libtool':       }
#    package { 'make':          }
#    package { 'mc':            }
#    package { 'patch':         }
#    package { 'pkg-config':    }
##    package { 'xz':            } # Does not exist in 5.0.3
#    package { 'zlib':          }
#    package { 'zlib-devel':    }

    package { 'zlib1g':        }
    package { 'zlib1g-dev':    }

    # Various basic packages
    package { 'arping':        }
    package { 'ethtool':       }
    package { 'hdparm':        }
    package { 'iperf':         }
    package { 'ntp':           }
    package { 'lynx':          }
}
