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



class a2o_essential_linux_libs::group::kvm {
    include 'a2o-essential-linux-libs::curl'
    include 'a2o-essential-linux-libs::cyrus-sasl'
    include 'a2o-essential-linux-libs::glib'
    include 'a2o-essential-linux-libs::gnutls'
    include 'a2o_essential_linux_libs::libcap_ng'
    include 'a2o-essential-linux-libs::libgcrypt'
    include 'a2o-essential-linux-libs::libiconv'
    include 'a2o_essential_linux_libs::libnl'
    include 'a2o_essential_linux_libs::yajl'
    include 'a2o_essential_linux_libs::zlib'
}
