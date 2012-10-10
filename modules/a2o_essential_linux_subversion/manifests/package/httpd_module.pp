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



### Software package: subversion httpd module
class   a2o_essential_linux_subversion::package::httpd_module   inherits   a2o_essential_linux_subversion::package::base {

    # External variables
    $packageTag_httpd = $a2o_linux_httpd::package::base::packageTag_httpd
    $destDir_httpd    = $a2o_linux_httpd::package::base::destDir_httpd


    # Package / Software details
    # CheckURI: http://subversion.apache.org/download/
    $softwareName     = "${packageTag_httpd}-svn"
    $softwareVersion  = '1.7.7'   # WARNING 1.7.6 has bugs, does not build without a patch
    $packageRelease   = '1'
    $packageTag       = "$softwareName-$softwareVersion-$packageRelease"
    $destDir          = "$destDir_httpd"


    ### Additinal versions
    $externalDestDir_openssl = '/usr/local/openssl-1.0.0i-1'


    ### Package
    $require = [
        Package['openssl'],
        Package['httpd'],
    ]
    a2o-essential-unix::compiletool::package::generic { "$packageTag":
	require             => $require,
	installScriptTplUri => "$thisPuppetModule/install-svn-httpd-module.sh"
    }


    ### Dependency chain
    Package['httpd'] -> Package["$softwareName"] -> File['/usr/local/httpd']
    Package["$softwareName"] ~> Service['a2o-linux-httpd']
}
