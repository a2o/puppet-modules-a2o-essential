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



class a2o_essential_linux_tools::group::all {
#    include 'a2o-essential-linux-tools::ant'
    include 'a2o-essential-linux-tools::bc'
    include 'a2o-essential-linux-tools::bridge-utils'
    include 'a2o_essential_linux_tools::cmake'
    include 'a2o-essential-linux-tools::conntrack-tools'
    include 'a2o-essential-linux-tools::dstat'
    include 'a2o-essential-linux-tools::git::all'
    include 'a2o_essential_linux_tools::gnupg'
    include 'a2o-essential-linux-tools::hdparm'
    include 'a2o-essential-linux-tools::ifenslave'
    include 'a2o_essential_linux_tools::ifupdown'
    include 'a2o-essential-linux-tools::imagemagick'
    include 'a2o-essential-linux-tools::inotify-tools'
    include 'a2o-essential-linux-tools::iotop'
    include 'a2o-essential-linux-tools::iperf'
    include 'a2o-essential-linux-tools::iptables'
# Disabled because compilation fails on 64-bit platforms
#    include 'a2o-essential-linux-tools::latencytop'
    include 'a2o_essential_linux_tools::lftp'
    include 'a2o-essential-linux-tools::mlocate'
    include 'a2o-essential-linux-tools::netcat'
    include 'a2o-essential-linux-tools::nmap'
# No use ATM
#    include 'a2o_essential_linux_tools::noweb'
    include 'a2o_essential_linux_tools::patchelf'
    include 'a2o-essential-linux-tools::pciutils'
    include 'a2o-essential-linux-tools::procps'
    include 'a2o-essential-linux-tools::psmisc'
    include 'a2o-essential-linux-tools::pstre'
    include 'a2o-essential-linux-tools::pv'
    include 'a2o-essential-linux-tools::quota'
    include 'a2o-essential-linux-tools::scons'
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
