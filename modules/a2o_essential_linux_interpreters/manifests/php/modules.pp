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



### Software package: php modules
class   a2o_essential_linux_interpreters::php::modules   inherits   a2o_essential_linux_interpreters::php::base {

    # External references
    $packageTag_php = $a2o_essential_linux_interpreters::php::package::packageTag
    $destDir_php    = $a2o_essential_linux_interpreters::php::package::destDir

    # Package / Software details
    # CheckURI: No version here, only below at actual modules
    $softwareName      = "$packageTag_php-modules"
    $softwareVersion   = '0.1.0'
    $packageRelease    = '1'
    $packageTag        = "$softwareName-$softwareVersion-$packageRelease"


    ### Actual module versions
    $softwareVersion_zf = '1.12.1'


    ### Package
    $require = [
        Package['php-cli'],
    ]
    a2o-essential-unix::compiletool::package::generic { "$packageTag":
	require             => $require,
	installScriptTplUri => "$thisPuppetModule/install-php-modules.sh",
    }


    ### Dependency chaining
    Package['php-cli'] -> Package["$softwareName"] -> File['/usr/local/php-cli']
}
