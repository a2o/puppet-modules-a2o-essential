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

### Final all-containing class
class a2o-essential-linux-libs::all {
    include 'a2o-essential-linux-libs::apr'
    include 'a2o-essential-linux-libs::apr-util'
    include 'a2o-essential-linux-libs::berkeley-db'
    include 'a2o-essential-linux-libs::cairo'
    include 'a2o-essential-linux-libs::confuse'
    include 'a2o-essential-linux-libs::curl'
    include 'a2o-essential-linux-libs::eventlog'
    include 'a2o-essential-linux-libs::expat'
    include 'a2o-essential-linux-libs::fontconfig'
    include 'a2o-essential-linux-libs::freetds'
    include 'a2o-essential-linux-libs::freetype'
    include 'a2o-essential-linux-libs::gd'
    include 'a2o-essential-linux-libs::gdbm'
    include 'a2o-essential-linux-libs::gettext'
    include 'a2o-essential-linux-libs::glib'
    include 'a2o-essential-linux-libs::imap'
    include 'a2o-essential-linux-libs::intltool'
    include 'a2o-essential-linux-libs::libevent'
    include 'a2o-essential-linux-libs::libffi'
    include 'a2o-essential-linux-libs::libiconv'
    include 'a2o-essential-linux-libs::libiodbc'
    include 'a2o-essential-linux-libs::libjpeg'
    include 'a2o-essential-linux-libs::libmcrypt'
    include 'a2o-essential-linux-libs::libmilter'
    include 'a2o-essential-linux-libs::libpcap'
    include 'a2o-essential-linux-libs::libpng'
    include 'a2o-essential-linux-libs::libxml2'
    include 'a2o-essential-linux-libs::libxslt'
    include 'a2o-essential-linux-libs::neon'
    include 'a2o-essential-linux-libs::pango'
    include 'a2o-essential-linux-libs::pcre'
    include 'a2o-essential-linux-libs::pixman'
    include 'a2o-essential-linux-libs::rrdtool'
    include 'a2o-essential-linux-libs::sqlite'
    include 'a2o-essential-linux-libs::unixodbc'
    include 'a2o-essential-linux-libs::zlib'
}

#class a2o-essential-linux-libs::package::libs {
    ### Require all libs
    ### Create fake package libs with nothing to install
#}

#class a2o-essential-linux-libs {
    ### Include all libs and libs package
#}
