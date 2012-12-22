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



### Software package: python mysql module
class   a2o_essential_linux_interpreters::python::module_mysql   inherits   a2o_essential_linux_interpreters::python::base {

    # External references
    $packageTag_python    = $a2o_essential_linux_interpreters::python::package::packageTag
    $softwareName_modules = $a2o_essential_linux_interpreters::python::module_collection::softwareName
    $destDir_python       = $a2o_essential_linux_interpreters::python::package::destDir

    # Package / Software details
    # CheckURI: http://pypi.python.org/pypi/MySQL-python
    $softwareName     = "$packageTag_python-module_mysql"
    $softwareVersion  = '1.2.3'
    $packageRelease   = '2'
    $packageTag       = "$softwareName-$softwareVersion-$packageRelease"

    ### External dependencies
    $externalDestDir_mysql = '/usr/local/mysql-5.1.66-1'


    ### Package
    $require = [
        Package['mysql'],
        Package['python'],
        Package["$softwareName_modules"],
    ]
    a2o-essential-unix::compiletool::package::generic { "$packageTag":
        require             => $require,
        installScriptTplUri => "$thisPuppetModule/install-python-module-mysql.sh",
    }


    ### Dependency chaining
    Package["$softwareName"] -> File['/usr/local/python']
}
