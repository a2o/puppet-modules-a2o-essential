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



### Software package: perl
class   a2o_essential_linux_interpreters::perl::package   inherits   a2o_essential_linux_interpreters::perl::base {

    # Package / Software details
    # CheckURI: http://www.perl.org
    $softwareName     = 'perl'
    $softwareVersion  = '5.16.3'
    $packageRelease   = '1'
    $packageTag       = "$softwareName-$softwareVersion-$packageRelease"
    $destDir          = "/usr/local/$packageTag"


    ### Package
    $require = [
#        Package['berkeley-db'],
##        Package['bzip2'],       # Usually installed on the system?
#        Package['curl'],
#        Package['expat'],
#        Package['freetds'],
##        Package['gd'],          # This one is bundled with PHP
#        Package['gettext'],
#        Package['gmp'],
#        Package['icu'],
#        Package['imap'],
#        Package['libiconv'],     # Not really needed (according to manual)
#        Package['libiodbc'],
#        Package['libmcrypt'],
#        Package['libxml2'],
#        Package['libxslt'],
##        Package['ncurses'],     # Usually installed on the system?
#        Package['openldap'],
#        Package['openssl'],
#        Package['pcre'],
#        Package['postgresql'],
##        Package['readline'],    # Usually installed on the system?
#        Package['sqlite'],
#        Package['tidy'],
#        Package['unixodbc'],
#        Package['zlib'],
    ]
    a2o-essential-unix::compiletool::package::generic { "$packageTag":
	require             => $require,
	installScriptTplUri => "$thisPuppetModule/install-perl.sh",
    }


    ### Symlink
    file { "/usr/local/$softwareName":
	ensure  => "$packageTag",
	require => [
	    Package["$softwareName"],
	],
	backup   => false,
    }
}
