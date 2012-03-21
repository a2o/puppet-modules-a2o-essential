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
#
# Type for managing MySQL databases.
#
Puppet::Type.newtype :mysql_database do



    #
    # Type documentation.
    #
    @doc = "MySQL database management. Creates or drops databases."



    #
    # The resource can be created and destroyed
    #
    ensurable



    #
    # Database name
    #
    newparam(:name) do
	desc "The name of the database. Can only contain alphanumeric characters and an underscore."
	newvalues(/^[a-zA-Z0-9_]{1,64}$/)
    end



    #
    # Force the removal
    #
    newparam(:force, :boolean => true) do
        desc "Force the database operation. Only used when removing non-empty databases."
        newvalues(:true, :false)
        defaultto false
    end
end
