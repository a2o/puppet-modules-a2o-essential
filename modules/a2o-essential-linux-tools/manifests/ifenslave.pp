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



### Software package: ifenslave
class   a2o-essential-linux-tools::ifenslave   inherits   a2o-essential-linux-tools::base {

    # Software details
    # CheckURI: http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=tree;f=Documentation/networking;h=67230c0792e4bb0e7bf37987b8412faf9e5180e6;hb=HEAD
    $softwareName     = 'ifenslave'
    $softwareVersion  = '1.1.0'
    $packageRelease   = '1'
    $packageTag       = "$softwareName-$softwareVersion-$packageRelease"


    # Installation
    a2o-essential-unix::compiletool::package::generic { "$packageTag": }
}
