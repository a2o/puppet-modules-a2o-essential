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



### Configuration files and directories
class   a2o-essential-linux-rsync::configuration   inherits   a2o-essential-linux-rsync::base {

    # Template
    File {
        owner    => root,
        group    => root,
        mode     => 644,
    }


    # Configuration file
    file { '/etc/rsyncd.conf':
	source   => "puppet:///modules/$thisPuppetModule/rsyncd.conf",
    }

    # Exclude filters
    file { '/etc/rsyncd':   ensure => directory, mode => 755 }
    file { '/etc/rsyncd/rsync-filter.fs':     source => "puppet:///modules/$thisPuppetModule/rsync-filter.fs"   }
    file { '/etc/rsyncd/rsync-filter.var':    source => "puppet:///modules/$thisPuppetModule/rsync-filter.var"  }
    file { '/etc/rsyncd/rsync-filter.home':   source => "puppet:///modules/$thisPuppetModule/rsync-filter.home" }
    file { '/etc/rsyncd/rsync-filter.www':    source => "puppet:///modules/$thisPuppetModule/rsync-filter.www"  }
    file { '/etc/rsyncd/rsync-filter.svn':    source => "puppet:///modules/$thisPuppetModule/rsync-filter.svn"  }
}
