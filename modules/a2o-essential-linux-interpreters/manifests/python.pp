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
# Authors: Bostjan Skufca <bostjan@a2o.si>                                #
###########################################################################



### Software packages basics: python
class   a2o-essential-linux-interpreters::python::base   inherits   a2o-essential-linux-interpreters::base {

    $packageName_python                    = "python"
    $packageSoftwareName_python            = "python"
    # CheckURI: http://www.python.org/download/
    $packageSoftwareVersion_python         = '2.6.6'
    $packageRelease_python                 = '1'
    $packageEnsure_python                  = "$packageSoftwareVersion_python-$packageRelease_python"
    $packageTag_python                     = "$packageName_python-$packageEnsure_python"
    $destDir_python                        = "/usr/local/$packageTag_python"


    # Global destination directory
    $destDirSymlink      = "/usr/local/python"
    $destDirSymlink_dest = "$packageTag_python"
}



### Software package: python
class   a2o-essential-linux-interpreters::python::package   inherits   a2o-essential-linux-interpreters::python::base {

    # Software details
    $packageName            = "$packageName_python"
    $packageSoftwareName    = "$packageSoftwareName_python"
    $packageSoftwareVersion = "$packageSoftwareVersion_python"
    $packageRelease         = "$packageRelease_python"
    $packageEnsure          = "$packageEnsure_python"
    $packageTag             = "$packageTag_python"
    $installScriptTpl       = "install-$packageSoftwareName.sh"
    $installScript          = "install-$packageTag.sh"

    # Destination directory:
    $destDir = "$destDir_python"


    # Installation
    file { "$compileDir/$installScript":
	content  => template("$thisPuppetModule/$installScriptTpl"),
        owner    => root,
        group    => root,
        mode     => 755,
    }
    package { "$packageName":
	provider => 'a2o_linux_compiletool',
        ensure   => "$packageEnsure",
	source   => "$compileDir/$installScript",
	require  => [ 
	    File["$compileDir/$installScript"], 
	    Package['openssl'],
	 ],
    }


    # Symlink
    file { "$destDirSymlink":
	ensure   => "$destDirSymlink_dest",
	require  => [ 
	    Package["$packageName_python"],
	],
	backup   => false,
    }
}



class a2o-essential-linux-interpreters::python {
    include 'a2o-essential-linux-interpreters::python::package'
}
