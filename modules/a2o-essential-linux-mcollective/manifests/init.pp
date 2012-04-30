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



### Base class
class   a2o-essential-linux-mcollective::base {

    # This mcollective module name
    $thisPuppetModule = 'a2o-essential-linux-mcollective'
}



### Software package - mcollective
class   a2o-essential-linux-mcollective::package   inherits   a2o-essential-linux-mcollective::base {

    # External software versions
    $externalDestDir_openssl = '/usr/local/openssl-1.0.0i-1'

    # Software details
    $softwareName    = 'mcollective'
    $softwareVersion = '1.2.1'
    $packageRelease  = '4'
    $packageTag      = "$softwareName-$softwareVersion-$packageRelease"

    # Extra details
    $pluginsVersion  = '0.5.0'

    # Package
    a2o-essential-unix::compiletool::package::generic { "$packageTag":   require => $require, }

    # Symlink
    file { "/usr/local/$softwareName":
        ensure   => "$packageTag",
	require  => Package["$softwareName"],
	backup   => false,
    }
}



### The final all-containing classes
class   a2o-essential-linux-mcollective {
    include 'a2o-essential-linux-mcollective::package'
}
