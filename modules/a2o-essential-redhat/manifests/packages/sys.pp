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
class   a2o-essential-redhat::packages::sys   inherits   a2o-essential-redhat::packages::base {

    # Compile time packages
    package { 'gcc':          }
    package { 'gcc-c++':      }
#    package { 'gettext':      }
    package { 'libtool':      }
    package { 'make':         }
    package { 'patch':        }
    package { 'pkgconfig':    }
    package { 'xz':           }
    package { 'zlib':         }
    package { 'zlib-devel':   }

    # Various system tools
    package { 'iotop':        }
    package { 'iptraf':       }
    package { 'lsof':         }
    package { 'mc':           }
    package { 'nc':           }
    package { 'ntp':          }
    package { 'screen':       }
    package { 'strace':       }
    package { 'telnet':       }
}
