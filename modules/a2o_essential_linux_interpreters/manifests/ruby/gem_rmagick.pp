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



### Software package: ruby postgresql gem
class   a2o_essential_linux_interpreters::ruby::gem_rmagick   inherits   a2o_essential_linux_interpreters::ruby::base {

    # External references
    $packageTag_ruby = $a2o_essential_linux_interpreters::ruby::package::packageTag
    $destDir_ruby    = $a2o_essential_linux_interpreters::ruby::package::destDir

    # Package / Software details
    $softwareName     = "$packageTag_ruby-gem_rmagick"
    $softwareVersion  = '0.1.0'
    $packageRelease   = '1'
    $packageTag       = "$softwareName-$softwareVersion-$packageRelease"



    ### Package
    $require = [
        Package['ruby'],
        Package['imagemagick'],
    ]
    a2o-essential-unix::compiletool::package::generic { "$packageTag":
	require             => $require,
	installScriptTplUri => "$thisPuppetModule/install-ruby-gem-rmagick.sh",
    }


    ### Dependency chaining
    Package["$softwareName"] -> File['/usr/local/ruby']
}
