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
class   a2o_essential_ubuntu::packages::workstation   inherits   a2o-essential-debian::packages {

    Package {
	provider => apt,
	ensure   => present,
    }

    ### All the packages that are required
    package { 'iptraf':        }
    package { 'lsof':          }
    package { 'mc':            }
    package { 'nano':          }
    package { 'strace':        }

    ### Browsers
    # For Google Chrome
    package { 'libgconf2-4':            }
    package { 'libxss1':                }
    package { 'google-chrome-stable':   }

    package { 'chromium-browser':   }

    package { 'lm-sensors':   }

    # For workspace configuration
    package { 'compizconfig-settings-manager':   }

    # Tools
    package { 'git':            }
    package { 'default-jre':    }
    package { 'transmission':            }
}
