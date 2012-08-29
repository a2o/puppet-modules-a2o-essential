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



### a2o UserGroup definition for daemons
#
# Template for creating system users and groups for daemons.
# These do not allow shell login from outside.

define   a2o-essential-unix::usergroup::daemon (
    $uid,
    $group = '',
    $gid   = '',
    $home  = '',
    $shell = '/bin/bash',
) {


    ###
    ### Defaults
    ###
    $realUser = $name
    $realUid  = $uid
    if $group != undef { $realGroup = "$group" } else { $realGroup = "$user"      }
    if $gid   != undef { $realGid   = "$gid"   } else { $realGid   = "$uid"       }
    if $home  != undef { $realHome  = "$home"  } else { $realHome  = "/var/$user" }
    if $shell != undef { $realShell = "$shell" } else { $realShell = "/bin/bash"  } # FIXME change to FALSE


    ###
    ### Create group
    ###
    group { "$realGroup":
        ensure     => present,
        gid        => $realGid,
    }


    ###
    ### Create user
    ###
    user { "$realUser":
        require    => Group["$realGroup"],
        uid        => $realUid,
        gid        => $realGid,
        provider   => useradd,
        allowdupe  => false,
        ensure     => present,
        password   => '*',
        shell      => "$realShell",
        managehome => true,
        home       => "$realHome",
    }


    ###
    ### Create homedir
    ###
    # Already managed by user definition (managehome)
}
