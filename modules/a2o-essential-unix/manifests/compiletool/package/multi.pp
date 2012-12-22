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



### Multi-instance a2o compiletool package definition
#
# Template for installing packages. Creates install file from template that
# resides in module where this thingie was called from. Then executes it :)

define   a2o-essential-unix::compiletool::package::multi (
    $installScriptTplUri = undef,
    $compileDirPath      = undef,
    $require             = []
) {

    a2o-essential-unix::compiletool::package::generic { "$name":
	packageNameLong     => 1,
	installScriptTplUri => $installScriptTplUri,
	compileDirPath      => $compileDirPath,
	require             => $require
    }
}
