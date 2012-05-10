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

    # Where the packages will be compiled
    $compileDir = '/var/src/tools'
}



### All defined tools
class a2o-essential-linux-tools::all {
#    include 'a2o-essential-linux-tools::ant'
    include 'a2o-essential-linux-tools::bc'
    include 'a2o-essential-linux-tools::bridge-utils'
    include 'a2o-essential-linux-tools::conntrack-tools'
    include 'a2o-essential-linux-tools::dstat'
    include 'a2o-essential-linux-tools::git'
    include 'a2o-essential-linux-tools::git::symlinks'
    include 'a2o-essential-linux-tools::hdparm'
    include 'a2o-essential-linux-tools::imagemagick'
    include 'a2o-essential-linux-tools::inotify-tools'
    include 'a2o-essential-linux-tools::iotop'
    include 'a2o-essential-linux-tools::iperf'
    include 'a2o-essential-linux-tools::iptables'
# Disabled because compilation fails on 64-bit platforms
#    include 'a2o-essential-linux-tools::latencytop'
    include 'a2o-essential-linux-tools::netcat'
    include 'a2o-essential-linux-tools::nmap'
    include 'a2o-essential-linux-tools::pciutils'
    include 'a2o-essential-linux-tools::procps'
    include 'a2o-essential-linux-tools::psmisc'
    include 'a2o-essential-linux-tools::pstre'
    include 'a2o-essential-linux-tools::pv'
    include 'a2o-essential-linux-tools::quota'
    include 'a2o-essential-linux-tools::sdparm'
    include 'a2o-essential-linux-tools::slocate'
    include 'a2o-essential-linux-tools::socat'
    include 'a2o-essential-linux-tools::tcpdump'
    include 'a2o-essential-linux-tools::tidy'
    include 'a2o-essential-linux-tools::tig'
    include 'a2o-essential-linux-tools::vmtouch'
    include 'a2o-essential-linux-tools::wget'
    include 'a2o-essential-linux-tools::wput'
    include 'a2o-essential-linux-tools::xz'
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
