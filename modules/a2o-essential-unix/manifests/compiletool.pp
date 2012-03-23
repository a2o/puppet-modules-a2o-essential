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



### Compilation tools
class a2o-essential-unix::compiletool inherits a2o-essential-unix::base {

    # Template
    File {
        owner    => root,
        group    => root,
        mode     => 755,
    }


    # Build directories
    file { [
	'/var/src',
	'/var/src/apps',
	'/var/src/bench',
	'/var/src/daemons',
	'/var/src/fake',
	'/var/src/interpreters',
	'/var/src/libs',
	'/var/src/migrations',
	'/var/src/sys',
	'/var/src/test',
	'/var/src/tmp',
	'/var/src/tools',
	'/var/src/upgrades'
	]:
	ensure   => directory,
    }


    # Build log directory - serves as indicator of what is already installed
    file { "/var/log/packages_compiled":
	ensure   => directory,
    }


    # Script with compilation helper functions
    file { '/var/src/build_functions.sh':
        source  => "puppet:///modules/$thisPuppetModule/compiletool/build_functions.sh",
	require => File['/var/log/packages_compiled'],
    }

    # FIXME remove at some point
    file { '/var/src/_functions.sh':
	ensure  => 'build_functions.sh',
	require => File['/var/src/build_functions.sh'],
    }
}



### Fake package class
# If package is installed by means not manageable by puppet, create fake package to trick
# puppet into thinking that 'require' dependencies are satisfied.
#
class   a2o-essential-unix::compiletool::fake-package($name, $ensure='0.0.0-0')   inherits a2o-essential-unix::base {
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
