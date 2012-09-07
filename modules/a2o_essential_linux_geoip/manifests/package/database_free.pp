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



### Software package: geoip database
class   a2o_essential_linux_geoip::package::database_free   inherits   a2o_essential_linux_geoip::package::base {

    # Package / Software details
    # CheckURI: http://www.maxmind.com/download/geoip/database/
    # INFO: There is no version information in files, just last-update dates can be read.
    # INFO: Thus, just bump version to the latest date in YYYYMMDD format, the rest is done
    # INFO: automagically.
    $softwareName     = 'geoip-database-free'
    $softwareVersion  = '20120808'
    $packageRelease   = '1'
    $packageTag       = "$softwareName-$softwareVersion-$packageRelease"
    $destDir          = "/var/geoip/GeoIP"


    ### Package
    a2o-essential-unix::compiletool::package::generic { "$packageTag": }


    ### Dependency chaining
    Package["$softwareName"] -> Package['geoip']
}
