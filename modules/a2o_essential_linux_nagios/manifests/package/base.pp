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



### Software package base class
class   a2o_essential_linux_nagios::package::base   inherits   a2o_essential_linux_nagios::base {

    # Package / Software details
    # CheckURI: http://www.nagios.org/download/core/thanks/
    $softwareName_nagios     = 'nagios'
    $softwareVersion_nagios  = '3.4.1'
    $packageRelease_nagios   = '1'
    $packageTag_nagios       = "$softwareName_nagios-$softwareVersion_nagios-$packageRelease_nagios"
    $destDir_nagios          = "/usr/local/$packageTag_nagios"


    # Where packages are compiled
    $compileDir = '/var/src/daemons'
}
