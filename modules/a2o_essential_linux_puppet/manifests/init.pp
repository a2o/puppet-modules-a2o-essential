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



### Base class
class   a2o_essential_linux_puppet::base {

    # This puppet module name
    $thisPuppetModule = 'a2o_essential_linux_puppet'

    # External software versions
    $externalDestDir_openssl = '/usr/local/openssl-1.0.0i-1'
}



### Software packages basics
class   a2o_essential_linux_puppet::package::base   inherits   a2o_essential_linux_puppet::base {

    $packageName_puppet            = "puppet"
    $packageSoftwareName_puppet    = "puppet"

    # CheckURI: http://puppetlabs.com/puppet/puppet-enterprise/
    $packageSoftwareVersion_puppet = '2.7.20'
    $packageRelease_puppet         = '1'
    $packageEnsure_puppet          = "${packageSoftwareVersion_puppet}-${packageRelease_puppet}"
    $packageTag_puppet             = "${packageName_puppet}-${packageEnsure_puppet}"

    $packageName_ruby              = "${packageTag_puppet}-ruby"
    $packageSoftwareName_ruby      = "ruby"
    # CheckURI for compatibility with puppet
    # CheckURI: http://docs.puppetlabs.com/guides/platforms.html
    $packageSoftwareVersion_ruby   = '1.8.7_p370'
    $packageRelease_ruby           = '1'
    $packageEnsure_ruby            = "${packageSoftwareVersion_ruby}-${packageRelease_ruby}"
    $packageTag_ruby               = "${packageName_ruby}-${packageEnsure_ruby}"

    $packageName_facter            = "${packageTag_puppet}-facter"
    $packageSoftwareName_facter    = "facter"
    # CheckURI:http://projects.puppetlabs.com/projects/1/wiki/Downloading_Puppet
    $packageSoftwareVersion_facter = '1.6.18'
    $packageRelease_facter         = '1'
    $packageEnsure_facter          = "${packageSoftwareVersion_facter}-${packageRelease_facter}"
    $packageTag_facter             = "${packageName_facter}-${packageEnsure_facter}"


    # Global destination directory
    $destDir             = "/usr/local/puppet-$packageEnsure_puppet"
    $destDirSymlink      = "/usr/local/puppet"
    $destDirSymlink_dest = "$packageTag_puppet"

    # Where the packages will be compiled
    $compileDir = "/var/src/puppet"
}



### Software package: ruby
class   a2o_essential_linux_puppet::package::ruby   inherits   a2o_essential_linux_puppet::package::base {

    # Software details
    $packageName            = "$packageName_ruby"
    $packageSoftwareName    = "$packageSoftwareName_ruby"
    $packageSoftwareVersion = "$packageSoftwareVersion_ruby"
    $packageRelease         = "$packageRelease_ruby"
    $packageEnsure          = "$packageEnsure_ruby"
    $packageTag             = "$packageTag_ruby"
    $installScriptTpl       = "install-$packageSoftwareName.sh"
    $installScript          = "install-$packageTag.sh"


    # Installation
    file { "$compileDir":
	ensure   => directory,
        owner    => root,
        group    => root,
        mode     => 755,
    }
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
	    Package['openssl'],
#	    Package['zlib'],
	],
    }


    # Add RRD module manually
    $rrdFile = "$destDir/lib/ruby/site_ruby/1.8/$hardwaremodel-linux/RRDtool.so"
    file { "$rrdFile":
        source   => "puppet:///modules/$thisPuppetModule/RRDtool.so",
	owner    => root,
        group    => root,
	mode     => 755,
        require  => Package["$packageName"],
    }
}



### Software package: facter
class   a2o_essential_linux_puppet::package::facter   inherits   a2o_essential_linux_puppet::package::base {

    # Software details
    $packageName            = "$packageName_facter"
    $packageSoftwareName    = "$packageSoftwareName_facter"
    $packageSoftwareVersion = "$packageSoftwareVersion_facter"
    $packageRelease         = "$packageRelease_facter"
    $packageEnsure          = "$packageEnsure_facter"
    $packageTag             = "$packageTag_facter"
    $installScriptTpl       = "install-$packageSoftwareName.sh"
    $installScript          = "install-$packageTag.sh"


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
	    Package["$packageName_ruby"]
	],
    }
}



### Software package: puppet
class   a2o_essential_linux_puppet::package::puppet   inherits   a2o_essential_linux_puppet::package::base {

    # Software details
    $packageName            = "$packageName_puppet"
    $packageSoftwareName    = "$packageSoftwareName_puppet"
    $packageSoftwareVersion = "$packageSoftwareVersion_puppet"
    $packageRelease         = "$packageRelease_puppet"
    $packageEnsure          = "$packageEnsure_puppet"
    $packageTag             = "$packageTag_puppet"
    $installScriptTpl       = "install-$packageSoftwareName.sh"
    $installScript          = "install-$packageTag.sh"


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
	    Package["$packageName_facter"]
	],
    }


    # Symlink
    file { "$destDirSymlink":
	ensure   => "$destDirSymlink_dest",
	require  => Package["$packageName_puppet"],
	backup   => false,
    }


    # Program symlinks
    file { '/usr/local/bin/puppet':     ensure => "$destDirSymlink/bin/puppet",   require => File["$destDirSymlink"], }
    file { '/usr/local/sbin/puppetd':   ensure => "$destDirSymlink/sbin/puppetd", require => File["$destDirSymlink"], }
    file { '/usr/local/bin/facter':     ensure => "$destDirSymlink/bin/facter",   require => File["$destDirSymlink"], }
}



### All packages in single class
class   a2o_essential_linux_puppet::packages {
    include 'a2o_essential_linux_puppet::package::ruby'
    include 'a2o_essential_linux_puppet::package::facter'
    include 'a2o_essential_linux_puppet::package::puppet'
}



### Configuration files and directories
class   a2o_essential_linux_puppet::dirs   inherits   a2o_essential_linux_puppet::base {
    File {
        ensure => directory,
        owner  => root,
        group  => root,
        mode   => 755,
    }
    file { '/etc/puppet':         }
    file { '/var/lib/puppet':     }
#    file { '/opt/scripts':        }   # Define it in FHS, which gets included in basic definition
    file { '/opt/scripts/puppet': }
}
class   a2o_essential_linux_puppet::files   inherits   a2o_essential_linux_puppet::base {
    File {
        owner   => root,
        group   => root,
        mode    => 644,
    }
    file { "/etc/puppet/puppet.conf":
        content => template("$thisPuppetModule/puppet.conf"),
    }
    file { "/etc/puppet/namespaceauth.conf":
        content => template("$thisPuppetModule/namespaceauth.conf"),
    }
    file { '/opt/scripts/puppet/puppet.postrun.sh':
        source => "puppet:///modules/$thisPuppetModule/puppet.postrun.sh",
        mode    => 755,
    }
}



### Cron for periodic puppet runs
class   a2o_essential_linux_puppet::cron   inherits   a2o_essential_linux_puppet::base {
    file { '/opt/scripts/puppet/puppet.cron.sh':
        source => "puppet:///modules/$thisPuppetModule/puppet.cron.sh",
        owner  => root,
        group  => root,
        mode   => 755,
    }

    cron { "/opt/scripts/puppet/puppet.cron.sh":
	user    => root,
	minute  => fqdn_rand(57) + 3, # Three minute delay between puppet and puppet-sys
	command => '/opt/scripts/puppet/puppet.cron.sh > /dev/null 2>&1',
	require  => [
	    File['/usr/local/puppet'],
	    File['/etc/puppet/puppet.conf'],
	    File['/opt/scripts/puppet/puppet.postrun.sh'],
	    File['/opt/scripts/puppet/puppet.cron.sh'],
	],
    }
}



### The final all-containing classes
class   a2o_essential_linux_puppet {
    include 'a2o_essential_linux_puppet::packages'
    include 'a2o_essential_linux_puppet::dirs'
    include 'a2o_essential_linux_puppet::files'
#    include 'a2o_essential_linux_puppet::cron'
}
