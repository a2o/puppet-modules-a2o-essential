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



### Directories
class   a2o_essential_linux_rrdcached::files::dirs   inherits   a2o_essential_linux_rrdcached::base {

    File {
        ensure   => directory,
        owner    => root,
        group    => root,
        mode     => 755,
    }

    # Dirs
    file { '/var/rrdcached':           }
    file { '/var/rrdcached/journal':   }
}



### Include-all class for files
class   a2o_essential_linux_rrdcached::files {
    include 'a2o_essential_linux_rrdcached::files::dirs'
}
