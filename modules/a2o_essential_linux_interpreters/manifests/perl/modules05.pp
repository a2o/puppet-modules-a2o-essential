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



### Software package: perl modules 05
class   a2o_essential_linux_interpreters::perl::modules05   inherits   a2o_essential_linux_interpreters::perl::base {

    # External references
    $packageTag_perl = $a2o_essential_linux_interpreters::perl::package::packageTag
    $destDir_perl    = $a2o_essential_linux_interpreters::perl::package::destDir

    # Package / Software details
    # CheckURI: No version here, only below at actual modules
    $softwareName      = "$packageTag_perl-modules05"
    $softwareVersion   = '0.1.0'
    $packageRelease    = '2'
    $packageTag        = "$softwareName-$softwareVersion-$packageRelease"


    ### Actual module versions - in the install files


    ### Package
    $require = [
        Package['perl'],
	Package["$packageTag_perl-modules04"],
    ]
    a2o-essential-unix::compiletool::package::generic { "$packageTag":
	require             => $require,
	installScriptTplUri => "$thisPuppetModule/install-perl-modules05.sh",
    }


    ### Dependency chaining
    Package['perl'] -> Package["$softwareName"] -> File['/usr/local/perl']
}
