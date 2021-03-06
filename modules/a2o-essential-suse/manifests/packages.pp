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
class   a2o-essential-suse::packages   inherits   a2o-essential-suse::base {

    Package {
	provider => zypper,
	ensure   => present,
    }

    package { 'automake':      }
    package { 'autoconf':      }
    package { 'gcc':           }
    package { 'gcc-c++':       }
    package { 'libtool':       }
    package { 'make':          }
    package { 'mc':            }
    package { 'patch':         }
    package { 'pkg-config':    }
# CHECK in which repo is this one?
#    package { 'xz':            }
    package { 'zlib':          }
    package { 'zlib-devel':    }

#    package { 'gettext-runtime': }
#    a2o-essential-unix::compiletool::fake-package { 'gettext': }
#    Package['gettext-runtime'] -> Package['gettext']

    # Various basic packages
    package { 'lynx':          }
}
