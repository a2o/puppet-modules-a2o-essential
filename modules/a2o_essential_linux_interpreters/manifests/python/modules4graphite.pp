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



### Software package: python modules 4 graphite
class   a2o_essential_linux_interpreters::python::modules4graphite   inherits   a2o_essential_linux_interpreters::python::base {

    # External references
    $packageTag_python    = $a2o_essential_linux_interpreters::python::package::packageTag
    $softwareName_modules = $a2o_essential_linux_interpreters::python::module_collection::softwareName
    $destDir_python       = $a2o_essential_linux_interpreters::python::package::destDir

    # Package / Software details
    $softwareName     = "${packageTag_python}-modules4graphite"
    $softwareVersion  = '0.1.0'
    $packageRelease   = '1'
    $packageTag       = "$softwareName-$softwareVersion-$packageRelease"


    ### Package
    $require = [
        Package['python'],
        Package["$softwareName_modules"],
    ]
    a2o-essential-unix::compiletool::package::generic { "$packageTag":
        require             => $require,
        installScriptTplUri => "$thisPuppetModule/install-python-modules4graphite.sh",
    }


    ### Dependency chaining
    Package["$softwareName"] -> File['/usr/local/python']
}
