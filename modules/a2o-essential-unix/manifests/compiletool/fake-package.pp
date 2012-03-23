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



### Fake package class
# If package is installed by means not manageable by puppet, create fake package to trick
# puppet into thinking that 'require' dependencies are satisfied.
#
# In separate file so puppet finds it if called from other namespaces
#

class   a2o-essential-unix::compiletool::fake-package($name, $ensure='0.0.0-0')   inherits   a2o-essential-unix::base {
    $installFile = "/var/src/fake/install-${name}-${ensure}.sh"
    file { "$installFile":
        ensure  => present,
        source  => "puppet:///modules/$thisPuppetModule/compiletool/install-fake-package.sh",
        owner   => root,
        group   => root,
        mode    => 0755,
    }
    package { "$name":
        provider => 'a2o_linux_compiletool',
        ensure   => "$ensure",
        source   => "$installFile",
        require  => [
    	    File["$installFile"],
	],
    }
}
