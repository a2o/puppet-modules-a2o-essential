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



### Fake package definition
#
# If package is installed by means not manageable by puppet, create a fake
# package in your manifest to trick puppet into thinking that resource
# dependencies are satisfied.
#
# This definition is in separate file because otherwise puppet is unable to
# find it if called from other namespaces

define   a2o-essential-unix::compiletool::fake-package   ($ensure='0.0.0-0') {
    $installFile = "/var/src/fake/install-${name}-${ensure}.sh"
    file { "$installFile":
        ensure  => present,
        source  => "puppet:///modules/a2o-essential-unix/compiletool/install-fake-package.sh",
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
