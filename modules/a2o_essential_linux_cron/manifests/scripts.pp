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



### Helper scripts
class   a2o_essential_linux_cron::scripts   inherits   a2o_essential_linux_cron::base {

    # Template
    File {
        owner    => root,
        group    => root,
        mode     => 755,
    }

    file { '/opt/scripts/cron':                                       ensure => directory, mode => 755 }
    file { '/opt/scripts/cron/run-and-mail-if-error.sh':              source => "puppet:///modules/$thisPuppetModule/run-and-mail-if-error.sh"   }
    file { '/opt/scripts/cron/run-and-mail-if-output.sh':             source => "puppet:///modules/$thisPuppetModule/run-and-mail-if-output.sh"  }
    file { '/opt/scripts/cron/wget-and-mail-if-output.sh':            source => "puppet:///modules/$thisPuppetModule/wget-and-mail-if-output.sh" }
    file { '/opt/scripts/cron/wget-and-mail-if-output_no-delay.sh':   source => "puppet:///modules/$thisPuppetModule/wget-and-mail-if-output_no-delay.sh" }
}
