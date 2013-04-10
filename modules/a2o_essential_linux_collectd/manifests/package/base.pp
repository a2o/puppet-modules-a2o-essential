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



### Software package base class
class   a2o_essential_linux_collectd::package::base   inherits   a2o_essential_linux_collectd::base {

    $compileDir = '/var/src/daemons'

    # Package / Software details
    # CheckURI: http://www.collectd.org/downloads.html
    $softwareName_collectd    = 'collectd'
    $softwareVersion_collectd = '5.2.2'
    $packageRelease_collectd  = '1'
    $packageTag_collectd      = "$softwareName_collectd-$softwareVersion_collectd-$packageRelease_collectd"

    # External references
    $externalDestDir_openssl = '/usr/local/openssl-1.0.1e-2'
    $externalDestDir_mysql   = '/usr/local/mysql-5.5.30-1'
}
