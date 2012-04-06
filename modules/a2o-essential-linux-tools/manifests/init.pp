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
class a2o-essential-linux-tools::base {
    $thisPuppetModule = "a2o-essential-linux-tools"

    # External packages - TODO migrate to per-tool class file
    $externalPackageDestdir_openssl = '/usr/local/openssl-1.0.0h-1'

    # Where the packages will be compiled
    $compileDir = '/var/src/tools'
}



### All defined tools
class a2o-essential-linux-tools::all {
    include 'a2o-essential-linux-tools::conntrack-tools'
    include 'a2o-essential-linux-tools::git'
    include 'a2o-essential-linux-tools::git::symlinks'
    include 'a2o-essential-linux-tools::tig'
    include 'a2o-essential-linux-tools::xz'
}
class a2o-essential-linux-tools::all-tmp {
    include 'a2o-essential-linux-tools::conntrack-tools'
}



### Packages to include into a2o server linux distribution
class a2o-essential-linux-tools::package::tools {
    a2o-essential-unix::compiletool::fake-package { 'a2o-essential-linux-tools': }
    Class['a2o-essential-linux-tools::all'] -> Package['a2o-essential-linux-tools']
}



### Final all-containing class
class a2o-essential-linux-tools {
    ### Include all tools and the tools package
    include 'a2o-essential-linux-tools::all'
    include 'a2o-essential-linux-tools::package::tools'
}
