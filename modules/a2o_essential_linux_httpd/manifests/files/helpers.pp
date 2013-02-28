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



### Helpers
class   a2o_essential_linux_httpd::files::helpers   inherits   a2o_essential_linux_httpd::base {

    File {
        owner    => root,
        group    => root,
    }

    file { '/opt/scripts/httpd/stale-request-hunter.sh':              mode => 755, source => "puppet:///modules/$thisPuppetModule/stale-request-hunter.sh" }
    file { '/opt/scripts/httpd/stale-request-hunter.conf.defaults':   mode => 644, source => "puppet:///modules/$thisPuppetModule/stale-request-hunter.conf.defaults" }
}
