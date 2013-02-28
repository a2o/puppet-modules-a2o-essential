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



class a2o_essential_linux_interpreters::php::all {

    Package['a2o-essential-linux-libs'] -> Package['php-cli']

    if $a2o_php_cli_major_version == "5.2" {
	include 'a2o_essential_linux_interpreters::php::package52'
	include 'a2o_essential_linux_interpreters::php::modules52'
    } else {
	include 'a2o_essential_linux_interpreters::php::package'
	include 'a2o_essential_linux_interpreters::php::modules'
	include 'a2o_essential_linux_interpreters::php::modules02'
    }

    include 'a2o_essential_linux_interpreters::php::symlinks'
    include 'a2o_essential_linux_interpreters::php::files'
}
