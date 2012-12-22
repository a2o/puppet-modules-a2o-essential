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



### Software package: postgresql database initial content
class   a2o_essential_linux_postgresql::package::postgresql_db   inherits   a2o_essential_linux_postgresql::package::base {

    # Package / Software details
    $softwareName     = 'postgresql-db'
    $softwareVersion  = '0.1.0'
    $packageRelease   = '1'
    $packageTag       = "$softwareName-$softwareVersion-$packageRelease"

    # Destdir is from another class
    $destDir          = $a2o_essential_linux_postgresql::package::postgresql::destDir


    ### Package
    $require = [
        Package['postgresql'],
        User['postgresql'],
        File['/var/postgresql/data'],
    ]
    a2o-essential-unix::compiletool::package::generic { "$packageTag": require => $require, }


    ### Dependency chaining
    Package["$softwareName"] -> File['/usr/local/postgresql']
}
