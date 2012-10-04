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



### MyTop config files for root
class   a2o_essential_linux_mysql::files::mytop   inherits   a2o_essential_linux_mysql::base {

    # Template
    File {
        owner    => root,
        group    => root,
        mode     => 600,
    }

    # Config file
    file { '/root/.mytop':   content => template("$thisPuppetModule/.mytop") }
}
