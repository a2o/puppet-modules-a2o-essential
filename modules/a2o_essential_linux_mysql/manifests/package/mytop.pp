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



### Software package: mytop
class   a2o_essential_linux_mysql::package::mytop   inherits   a2o_essential_linux_mysql::package::base {

    # Package / Software details
    # CheckURI: http://jeremy.zawodny.com/mysql/mytop/
    $softwareName     = 'mytop'
    $softwareVersion  = '1.6'
    $packageRelease   = '2'
    $packageTag       = "$softwareName-$softwareVersion-$packageRelease"
    $destDir          = "/usr/local/$packageTag"

    # Other compile location
    $compileDir = '/var/src/tools'


    ### Package
    $require = [
        Package['perl'],
        File['/usr/local/perl'],
    ]
    a2o-essential-unix::compiletool::package::generic { "$packageTag": require => $require, }
}
