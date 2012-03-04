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
# Authors: Bostjan Skufca <bostjan@a2o.si>                                #
###########################################################################
#
# Type for managing MySQL database grants.
#
Puppet::Type.newtype :mysql_grant_db do



    #
    # Type documentation.
    #
    @doc = "MySQL database grant management. Manages user privileges for certain database."



    #
    # The resource can be created and destroyed
    #
    ensurable



    #
    # Userhost parameter (user@host)
    #
    newparam(:name) do
	desc "The user@host/database."
	newvalues(/^[-_.a-zA-Z0-9]{1,16}@[-a-zA-Z0-9%.]{1,60}\/[a-zA-Z0-9_]{1,64}$/)
    end



    #
    # Boolean privilege properties
    #
    properties_priv = [ \
	'select_priv', \
	'insert_priv', \
	'update_priv', \
	'delete_priv', \
	'create_priv', \
	'drop_priv', \
	'grant_priv', \
	'references_priv', \
	'index_priv', \
	'alter_priv', \
	'create_tmp_table_priv', \
	'lock_tables_priv', \
	'create_view_priv', \
	'show_view_priv', \
	'create_routine_priv', \
	'alter_routine_priv', \
	'execute_priv', \
	'event_priv', \
	'trigger_priv' \
    ]
    properties_priv.each { |property_priv|
	newproperty(symbolize(property_priv), :boolean => true) do
    	    desc "Database privilege " + property_priv.capitalize
	    newvalue(:false)
	    newvalue(:true)
	end
    }
end
