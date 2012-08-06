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



### Software package: python module collection
class   a2o_essential_linux_interpreters::python::module_collection   inherits   a2o_essential_linux_interpreters::python::base {

    # External references
    $packageTag_python = $a2o_essential_linux_interpreters::python::package::packageTag
    $destDir_python    = $a2o_essential_linux_interpreters::python::package::destDir

    # Package / Software details
    # CheckURI: No version here, only below at actual modules
    $softwareName      = "$packageTag_python-modules"
    $softwareVersion   = '0.1.0'
    $packageRelease    = '1'
    $packageTag        = "$softwareName-$softwareVersion-$packageRelease"


    ### Actual module versions
    # CheckURI: https://www.djangoproject.com/download/
    $softwareVersion_django = '1.4.1'


    ### Package
    $require = [
        Package['python'],
    ]
    a2o-essential-unix::compiletool::package::generic { "$packageTag":
	require             => $require,
	installScriptTplUri => "$thisPuppetModule/install-python-module-collection.sh",
    }


    ### Dependency chaining
    Package['python'] -> Package["$softwareName"] -> File['/usr/local/python']
}
