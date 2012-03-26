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
class   a2o-essential-linux-ganglia::base {
    $thisPuppetModule = 'a2o-essential-linux-ganglia'

    # External package references
    $externalPackageDestDir_python = '/usr/local/python-2.6.7-1'
}



### Users and groups
class   a2o-essential-linux-ganglia::users   inherits   a2o-essential-linux-ganglia::base {
    group { 'ganglia':
	ensure     => present,
#FIXME gids, uids, yes, no?
#	gid        => 8649,
    }
    user  { 'ganglia':
        require    => Group['ganglia'],
        provider   => useradd,
        allowdupe  => false,
        ensure     => present,
#        uid        => 8649,
#	gid        => 8649,
	gid        => ganglia,
	# TODO fix add entry to shadow file?
	#password   => '*',
	shell      => '/bin/bash',
	managehome => false,
    }
}



### Software package
class   a2o-essential-linux-ganglia::package   inherits   a2o-essential-linux-ganglia::base {

    # Software details
    $packageName      = 'ganglia'
    $packageSoftware  = 'ganglia'
    $packageVersion   = '3.1.7'
    $packageRelease   = '6'
    $packageEnsure    = "$packageVersion-$packageRelease"
    $packageTag       = "$packageSoftware-$packageEnsure"
    $installScriptTpl = "install-$packageSoftware.sh"
    $installScript    = "install-$packageTag.sh"

    # Where the packages will be compiled
    $compileDir = "/var/src/daemons"

    # Global destination directory
    $destDir             = "/usr/local/$packageTag"
    $destDirSymlink      = "/usr/local/$packageSoftware"
    $destDirSymlink_dest = "$packageTag"


    # Installation
    file { "$compileDir/$installScript":
	content  => template("$thisPuppetModule/$installScriptTpl"),
        owner    => root,
        group    => root,
        mode     => 755,
	require  => File['/var/src/build_functions.sh'],
    }
    package { "$packageName":
	provider => 'a2o_linux_compiletool',
        ensure   => "$packageEnsure",
	source   => "$compileDir/$installScript",
	require  => [
	    File["$compileDir/$installScript"],
	    Package['apr'],
	    Package['apr-util'],
	    Package['pcre'],
	    Package['python'],
	    Package['rrdtool'],
	    User['ganglia'],
	],
    }


    # Symlink
    file { "$destDirSymlink":
	ensure   => "$destDirSymlink_dest",
	require  => Package["$packageName"],
	backup   => false,
    }
}



### Software package
class   a2o-essential-linux-ganglia::package::gmond   inherits   a2o-essential-linux-ganglia::base {

    # Software details
    $packageName      = 'ganglia-gmond'
    $packageSoftware  = 'ganglia-gmond'
    $packageVersion   = '3.1.7'
    $packageRelease   = '7'
    $packageEnsure    = "$packageVersion-$packageRelease"
    $packageTag       = "$packageSoftware-$packageEnsure"
    $installScriptTpl = "install-$packageSoftware.sh"
    $installScript    = "install-$packageTag.sh"

    # Where the packages will be compiled
    $compileDir = "/var/src/daemons"

    # Global destination directory
    $destDir             = "/usr/local/$packageTag"
    $destDirSymlink      = "/usr/local/$packageSoftware"
    $destDirSymlink_dest = "$packageTag"


    # Installation
    file { "$compileDir/$installScript":
	content  => template("$thisPuppetModule/$installScriptTpl"),
        owner    => root,
        group    => root,
        mode     => 755,
	require  => File['/var/src/build_functions.sh'],
    }
    package { "$packageName":
	provider => 'a2o_linux_compiletool',
        ensure   => "$packageEnsure",
	source   => "$compileDir/$installScript",
	require  => [
	    File["$compileDir/$installScript"],
	    Package['apr'],
	    Package['apr-util'],
	    Package['pcre'],
	    Package['python'],
	    User['ganglia'],
	],
    }


    # Symlink
    file { "$destDirSymlink":
	ensure   => "$destDirSymlink_dest",
	require  => Package["$packageName"],
	backup   => false,
    }
}



### Configuration files and directories
class   a2o-essential-linux-ganglia::files   inherits   a2o-essential-linux-ganglia::base {

    file { "/etc/ganglia":
	ensure   => directory,
        owner    => root,
        group    => root,
        mode     => 755,
    }
}



### Configuration: gmond
class a2o-essential-linux-ganglia::files::gmond   inherits   a2o-essential-linux-ganglia::base {

    File {
        owner    => root,
        group    => root,
        mode     => 644,
	require  => [
	    File['/etc/ganglia'],
	    File['/usr/local/ganglia-gmond'],
	],
    }

    file { '/etc/ganglia/conf.d':                ensure => directory, mode => 755, }
    file { '/etc/ganglia/conf.d/a2o':            ensure => directory, source  => "puppet:///modules/$thisPuppetModule/conf.d/a2o",   recurse => true, }
    file { '/etc/ganglia/python_modules':        ensure => directory, mode => 755, }
    file { '/etc/ganglia/data_collectors':       ensure => directory, mode => 755, }
    file { '/etc/ganglia/data_collectors/a2o':   ensure => directory, mode => 755, source  => "puppet:///modules/$thisPuppetModule/data_collectors/a2o",   recurse => true, }

    file { '/etc/ganglia/gmond.conf':              content => template("$thisPuppetModule/gmond.conf"),                    }
    file { '/etc/ganglia/conf.d/modpython.conf':   source  => "puppet:///modules/$thisPuppetModule/conf.d/modpython.conf", }

    # Python modules
    file { '/etc/ganglia/python_modules/a2o_disk.py':   source  => "puppet:///modules/$thisPuppetModule/python_modules/a2o_disk.py", }
    file { '/etc/ganglia/python_modules/a2o_mail.py':   source  => "puppet:///modules/$thisPuppetModule/python_modules/a2o_mail.py", }
    file { '/etc/ganglia/python_modules/a2o_proc.py':   source  => "puppet:///modules/$thisPuppetModule/python_modules/a2o_proc.py", }
    file { '/etc/ganglia/python_modules/a2o_raid.py':   source  => "puppet:///modules/$thisPuppetModule/python_modules/a2o_raid.py", }
}



### Configuration: gmetad
class   a2o-essential-linux-ganglia::files::gmetad   inherits   a2o-essential-linux-ganglia::base {

    file { '/etc/ganglia/gmetad.conf':
	ensure   => present,
        owner    => root,
        group    => root,
        mode     => 644,
    }

    file { '/var/ganglia':
	ensure   => directory,
        owner    => nobody,
        group    => nogroup,
        mode     => 755,
    }
    file { '/var/ganglia/rrds':
	ensure   => directory,
        owner    => nobody,
        group    => nogroup,
        mode     => 755,
    }
}



### Service: gmond
class a2o-essential-linux-ganglia::service::gmond   inherits   a2o-essential-linux-ganglia::base {

    # Service details
    $serviceName      = 'gmond'
    $serviceState     = 'running'

    # Startup file
    file { "/etc/rc.d/rc.$serviceName":
        content  => template("$thisPuppetModule/rc.$serviceName"),
        owner    => root,
        group    => root,
        mode     => $serviceState ? {
    	    running => 755,
    	    stopped => 644,
    	    default => 644,
    	},
	require  => File['/etc/rc.d/rc._functions'],
    }


    # Service definition
    service { "a2o-essential-linux-$serviceName":
        enable      => $serviceState ? {
    	    running => true,
    	    stopped => false,
    	    default => false,
    	},
	ensure      => $serviceState,
	hasrestart  => true,
	hasstatus   => true,
	provider    => 'a2o_linux_rctool',
	binary      => "/etc/rc.d/rc.$serviceName",
	start       => "/etc/rc.d/rc.$serviceName start",
	restart     => "/etc/rc.d/rc.$serviceName restart",
	stop        => "/etc/rc.d/rc.$serviceName stop",
	status      => "/etc/rc.d/rc.$serviceName status",
	subscribe   => [
	    Package['ganglia-gmond'],
	    File['/etc/ganglia/gmond.conf'],
	    File['/etc/ganglia/conf.d/modpython.conf'],
	    File['/etc/ganglia/conf.d/a2o'],
	    File['/etc/ganglia/python_modules'],
	    File["/etc/rc.d/rc.$serviceName"],
	    User['ganglia'],
	    Group['ganglia'],
	],
	require     => [
	    Package['ganglia-gmond'],
	    File['/usr/local/ganglia-gmond'],
	    File['/etc/ganglia/gmond.conf'],
	    File['/etc/ganglia/conf.d/modpython.conf'],
	    File['/etc/ganglia/conf.d/a2o'],
	    File['/etc/ganglia/python_modules'],
	    File["/etc/rc.d/rc.$serviceName"],
	],
    }
}



### Service: gmetad
class a2o-essential-linux-ganglia::service::gmetad   inherits   a2o-essential-linux-ganglia::base {

    # Service details
    $serviceName      = 'gmetad'
    $serviceState     = 'running'

    # Startup file
    file { "/etc/rc.d/rc.$serviceName":
        source   => "puppet:///modules/$thisPuppetModule/rc.$serviceName",
        owner    => root,
        group    => root,
        mode     => $serviceState ? {
    	    running => 755,
    	    stopped => 644,
    	    default => 644,
    	},
	require  => File['/etc/rc.d/rc._functions'],
    }


    # Service definition
    service { "a2o-essential-linux-$serviceName":
        enable      => $serviceState ? {
    	    running => true,
    	    stopped => false,
    	    default => false,
    	},
	ensure      => $serviceState,
	hasrestart  => true,
	hasstatus   => true,
	provider    => 'a2o_linux_rctool',
	binary      => "/etc/rc.d/rc.$serviceName",
	start       => "/etc/rc.d/rc.$serviceName start",
	restart     => "/etc/rc.d/rc.$serviceName restart",
	stop        => "/etc/rc.d/rc.$serviceName stop",
	status      => "/etc/rc.d/rc.$serviceName status",
	subscribe   => [
	    Package['ganglia'],
	    Service['a2o-essential-linux-rrdcached'],
	    File['/usr/local/ganglia'],
	    File['/etc/ganglia/gmetad.conf'],
	    File["/etc/rc.d/rc.$serviceName"],
	],
	require     => [
	    Package['ganglia'],
	    Service['a2o-essential-linux-rrdcached'],
	    File['/usr/local/ganglia'],
	    File['/etc/ganglia/gmetad.conf'],
	    File['/var/ganglia/rrds'],
	    File["/etc/rc.d/rc.$serviceName"],
	],
    }
}



### The final all-containing classes
class a2o-essential-linux-ganglia::gmond {
    include 'a2o-essential-linux-ganglia::users'
    include 'a2o-essential-linux-ganglia::package::gmond'
    include 'a2o-essential-linux-ganglia::files'
    include 'a2o-essential-linux-ganglia::files::gmond'
    include 'a2o-essential-linux-ganglia::service::gmond'
}

class a2o-essential-linux-ganglia::gmetad {
    include 'a2o-essential-linux-ganglia::users'
    include 'a2o-essential-linux-ganglia::package'
    include 'a2o-essential-linux-ganglia::files'
    include 'a2o-essential-linux-ganglia::files::gmetad'
    include 'a2o-essential-linux-ganglia::service::gmetad'
}
