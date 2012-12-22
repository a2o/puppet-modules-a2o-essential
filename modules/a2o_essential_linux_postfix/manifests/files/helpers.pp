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



### Helper files
class   a2o_essential_linux_postfix::files::helpers   inherits   a2o_essential_linux_postfix::base {

    # Template
    File {
        owner    => root,
        group    => root,
        mode     => 755,
    }

    # Log analysis
    file { '/opt/scripts/postfix':                ensure => directory, mode => 755 }
    file { '/opt/scripts/postfix/pflogsumm.pl':   source => "puppet:///modules/$thisPuppetModule/pflogsumm/pflogsumm.pl" }
    file { '/opt/scripts/postfix/pflogsumm.1':    source => "puppet:///modules/$thisPuppetModule/pflogsumm/pflogsumm.1", mode => 644 }
}
