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



### Software package: mysql
class   a2o_essential_linux_mysql::package::mysql   inherits   a2o_essential_linux_mysql::package::base {

    # Package / Software details
    # CheckURI: http://ftp.arnes.si/mysql/Downloads/

    # WARNING: After fixing here, see below too
    #
    $softwareName       = 'mysql'
    $softwareVersion51  = '5.1.68'
    $packageRelease51   = '2'
    $softwareVersion55  = '5.5.30'
    $packageRelease55   = '1'
    $packageTag51       = "$softwareName-$softwareVersion51-$packageRelease51"
    $packageTag55       = "$softwareName-$softwareVersion55-$packageRelease55"
#    $destDir          = "/usr/local/$packageTag"



    # Requirements
    $require55 = [
	Package['cmake'],
	Package['openssl'],
    ]
    $require = [
	Package['openssl'],
    ]

    ### Additinal versions
    $externalDestDir_openssl = '/usr/local/openssl-1.0.1e-2'

    # Older versions - keep them, then move them to cleanup.pp
    a2o-essential-unix::compiletool::package::multi   { 'mysql-5.1.66-1':   require => $require, installScriptTplUri => "$thisPuppetModule/install-mysql.sh" }
    a2o-essential-unix::compiletool::package::multi   { 'mysql-5.1.67-1':   require => $require, installScriptTplUri => "$thisPuppetModule/install-mysql.sh" }


    # Current versions - WARNING! update symlinks below too
    if $version_major == '5.5' {
	$packageTag = $packageTag55
	a2o-essential-unix::compiletool::package::multi   { "$packageTag51":   require => $require,   installScriptTplUri => "$thisPuppetModule/install-mysql.sh" }
	a2o-essential-unix::compiletool::package::generic { "$packageTag55":   require => $require55, installScriptTplUri => "$thisPuppetModule/install-mysql.sh_5.5" }
    } else {
	$packageTag = $packageTag51
	a2o-essential-unix::compiletool::package::generic { "$packageTag51":   require => $require,   installScriptTplUri => "$thisPuppetModule/install-mysql.sh"}
    }


    if $version_major == '5.5' {
	$requireSymlink51 = [ Package["$packageTag51"] ]
	$requireSymlink55 = [ Package['mysql'] ]
    } else {
	$requireSymlink51 = [ Package['mysql'] ]
	$requireSymlink55 = []
    }

    ### Symlink for 5.1
    file { '/usr/local/mysql-5.1':
	ensure  => link,
	target  => "$packageTag51",
	require => $requireSymlink51,
	backup  => false,
    }

    ### Symlink for 5.5
    if $version_major == '5.5' {
	file { '/usr/local/mysql-5.5':
	    ensure  => link,
	    target  => "$packageTag55",
	    require => $requireSymlink55,
	    backup  => false,
	}
    }

    # Main symlink
    if $version_major == '5.5' {
	file { '/usr/local/mysql':
	    ensure  => link,
	    target  => 'mysql-5.5',
	    require => File['/usr/local/mysql-5.5'],
	    backup  => false,
	}
    } else {
	file { '/usr/local/mysql':
	    ensure  => link,
	    target  => 'mysql-5.1',
	    require => File['/usr/local/mysql-5.1'],
	    backup  => false,
	}
    }
}
