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
class a2o-essential-linux-libs::base {
    $thisPuppetModule = "a2o-essential-linux-libs"

    # Where the packages will be compiled
    $compileDir = '/var/src/libs'
}



### Libs required for ganglia installation
class a2o-essential-linux-libs::ganglia {
    include 'a2o-essential-linux-libs::apr'
    include 'a2o-essential-linux-libs::apr-util'
    include 'a2o-essential-linux-libs::cairo'
    include 'a2o-essential-linux-libs::confuse'
    include 'a2o-essential-linux-libs::expat'
    include 'a2o-essential-linux-libs::fontconfig'
    include 'a2o-essential-linux-libs::freetype'
    include 'a2o-essential-linux-libs::glib'
    include 'a2o-essential-linux-libs::libffi'
    include 'a2o-essential-linux-libs::libiconv'
    include 'a2o-essential-linux-libs::libpng'
    include 'a2o-essential-linux-libs::libxml2'
    include 'a2o-essential-linux-libs::pango'
    include 'a2o-essential-linux-libs::pcre'
    include 'a2o-essential-linux-libs::pixman'
    include 'a2o-essential-linux-libs::rrdtool'
}

class a2o-essential-linux-libs::nagios {
    include 'a2o-essential-linux-libs::gd'
    include 'a2o-essential-linux-libs::libiconv'
    include 'a2o-essential-linux-libs::libjpeg'
    include 'a2o-essential-linux-libs::libpng'
}

class a2o-essential-linux-libs::testing {
    include 'a2o-essential-linux-libs::net-snmp'
    include 'a2o-essential-linux-libs::openipmi'
}

### Final all-containing class
class a2o-essential-linux-libs::all {
    include 'a2o-essential-linux-libs::apr'
    include 'a2o-essential-linux-libs::apr-util'
    include 'a2o-essential-linux-libs::berkeley-db'
    include 'a2o-essential-linux-libs::boost'
    include 'a2o-essential-linux-libs::cairo'
    include 'a2o-essential-linux-libs::confuse'
    include 'a2o-essential-linux-libs::curl'
    include 'a2o-essential-linux-libs::cyrus-sasl'
    include 'a2o-essential-linux-libs::eventlog'
    include 'a2o-essential-linux-libs::expat'
    include 'a2o-essential-linux-libs::fontconfig'
    include 'a2o-essential-linux-libs::freetds'
    include 'a2o-essential-linux-libs::freetype'
    include 'a2o-essential-linux-libs::gd'
    include 'a2o-essential-linux-libs::gdbm'
    include 'a2o-essential-linux-libs::gettext'
    include 'a2o-essential-linux-libs::glib'
    include 'a2o-essential-linux-libs::gmp'
    include 'a2o-essential-linux-libs::gnutls'
    include 'a2o-essential-linux-libs::icu'
    include 'a2o-essential-linux-libs::imap'
    include 'a2o-essential-linux-libs::intltool'
    include 'a2o-essential-linux-libs::libevent'
    include 'a2o-essential-linux-libs::libffi'
    include 'a2o-essential-linux-libs::libgcrypt'
    include 'a2o-essential-linux-libs::libgearman'
    include 'a2o-essential-linux-libs::libgpg-error'
    include 'a2o-essential-linux-libs::libiconv'
    include 'a2o-essential-linux-libs::libiodbc'
    include 'a2o-essential-linux-libs::libjpeg'
    include 'a2o-essential-linux-libs::libmcrypt'
    include 'a2o-essential-linux-libs::libmemcached'
    include 'a2o-essential-linux-libs::libmilter'
    include 'a2o-essential-linux-libs::libnettle'
    include 'a2o-essential-linux-libs::liboping'
    include 'a2o-essential-linux-libs::libpcap'
    include 'a2o-essential-linux-libs::libpng'
    include 'a2o-essential-linux-libs::libssh2'
    include 'a2o-essential-linux-libs::libxml2'
    include 'a2o-essential-linux-libs::libxslt'
    include 'a2o-essential-linux-libs::neon'
    include 'a2o-essential-linux-libs::pango'
    include 'a2o-essential-linux-libs::pcre'
    include 'a2o-essential-linux-libs::pixman'
    include 'a2o-essential-linux-libs::popt'
    include 'a2o-essential-linux-libs::rrdtool'
    include 'a2o-essential-linux-libs::sqlite'
    include 'a2o-essential-linux-libs::unixodbc'
    include 'a2o-essential-linux-libs::zlib'
}



### Packages to include into a2o server linux distribution
class a2o-essential-linux-libs::package::libs {
    a2o-essential-unix::compiletool::fake-package { 'a2o-essential-linux-libs': }
    Class['a2o-essential-linux-libs::all'] -> Package['a2o-essential-linux-libs']
}

class a2o-essential-linux-libs {
    ### Include all libs and libs package
    include 'a2o-essential-linux-libs::all'
    include 'a2o-essential-linux-libs::package::libs'
}
