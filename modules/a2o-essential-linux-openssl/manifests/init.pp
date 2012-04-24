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



### Base class
class   a2o-essential-linux-openssl::base {
    $thisPuppetModule = 'a2o-essential-linux-openssl'
}



### All packages class
class   a2o-essential-linux-openssl::packages {

    # CheckURI: http://www.openssl.org/
    #
    # Packages 0.9.8x are old and kept here for legacy reasons, but to be removed ASAP
    # Packages 1.0.0x are current
    # Packages 1.0.1x and up are new, do not add them
    #
    # To add new version, just add new line below with new version
    #
    # The latest version (latest as in alphabetically) must not be defined as ::generic, but as ::latest
    # (puppet package name quirk)
    #
    # WARNING: If you add/remove packages, update symlinks below

    a2o-essential-linux-openssl::package::generic { 'openssl-0.9.8t-1': }
    a2o-essential-linux-openssl::package::generic { 'openssl-0.9.8u-1': }
    a2o-essential-linux-openssl::package::generic { 'openssl-0.9.8w-1': }
    a2o-essential-linux-openssl::package::generic { 'openssl-1.0.0h-1': }
    a2o-essential-linux-openssl::package::latest  { 'openssl-1.0.0i-1': }
}



### Symbolic links
class   a2o-essential-linux-openssl::symlinks {

    # WARNING:
    # WARNING: Don't change symlinks unless you know what you are doing
    # WARNING:

    ### Legacy symlink
    # Major version symlink
    file { '/usr/local/openssl-0.9.8':
	ensure   => 'openssl-0.9.8u-1',
	require  => Package['openssl-0.9.8u-1'],
	backup   => false,
    }

    ### Current symlink
    # Major version symlink
    file { '/usr/local/openssl-1.0.0':
	ensure   => 'openssl-1.0.0h-1',
	require  => [
	    Package['openssl-1.0.0h-1'],
	    Package['openssl'],
	],
	backup   => false,
    }
    # Final version symlink
    file { '/usr/local/openssl':
	ensure   => 'openssl-1.0.0',
	require  => File['/usr/local/openssl-1.0.0'],
	backup   => false,
    }
}



### The final all-containing classes
class   a2o-essential-linux-openssl {
    include 'a2o-essential-linux-openssl::packages'
    include 'a2o-essential-linux-openssl::symlinks'
}
