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



### Symlinks for mongodb programs
class   a2o-essential-linux-mongodb::symlinks {

    File {
	require => File['/usr/local/mongodb'],
    }

    ### Symlinks
    file { '/usr/local/bin/mongo':          ensure => '/usr/local/mongodb/bin/mongo', }
    file { '/usr/local/bin/mongodump':      ensure => '/usr/local/mongodb/bin/mongodump', }
    file { '/usr/local/bin/mongoexport':    ensure => '/usr/local/mongodb/bin/mongoexport', }
    file { '/usr/local/bin/mongoimport':    ensure => '/usr/local/mongodb/bin/mongoimport', }
    file { '/usr/local/bin/mongorestore':   ensure => '/usr/local/mongodb/bin/mongorestore', }
    file { '/usr/local/bin/mongos':         ensure => '/usr/local/mongodb/bin/mongos', }
    file { '/usr/local/bin/mongosniff':     ensure => '/usr/local/mongodb/bin/mongosniff', }
    file { '/usr/local/bin/mongostat':      ensure => '/usr/local/mongodb/bin/mongostat', }
    file { '/usr/local/bin/mongotop':       ensure => '/usr/local/mongodb/bin/mongotop', }
}
