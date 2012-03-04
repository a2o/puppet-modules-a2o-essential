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
# Type for managing MySQL users.
#
Puppet::Type.newtype :mysql_user do



    #
    # Type documentation.
    #
    @doc = "MySQL user management. Creates or drops users and sets privileges."



    #
    # The resource can be created and destroyed
    #
    ensurable



    #
    # Userhost parameter (user@host)
    #
    newparam(:name) do
	desc "The user@host."
	newvalues(/^[-_.a-zA-Z0-9]{1,16}@[-a-zA-Z0-9%.]{1,60}$/)
    end



    #
    # Password property
    #
    newproperty(:password) do
    	desc "Hashed password."
	newvalue(/^\*[A-Z0-9]{40}$/)
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
	'reload_priv', \
	'shutdown_priv', \
	'process_priv', \
	'file_priv', \
	'grant_priv', \
	'references_priv', \
	'index_priv', \
	'alter_priv', \
	'show_db_priv', \
	'super_priv', \
	'create_tmp_table_priv', \
	'lock_tables_priv', \
	'execute_priv', \
	'repl_slave_priv', \
	'repl_client_priv', \
	'create_view_priv', \
	'show_view_priv', \
	'create_routine_priv', \
	'alter_routine_priv', \
	'create_user_priv', \
	'event_priv', \
	'trigger_priv' \
    ]
    properties_priv.each { |property_priv|
	newproperty(symbolize(property_priv), :boolean => true) do
    	    desc "Global " + property_priv.capitalize
	    newvalue(:false)
	    newvalue(:true)
	end
    }



    #
    # SSL properties
    #
    # ssl_type can contain only few distinct values
    newproperty(symbolize(:ssl_type)) do
    	desc "SSL type required for connection. Possible values are empty, 'ANY', 'X509' or 'SPECIFIED'"
	newvalue(:empty)
	newvalue('ANY')
	newvalue('X509')
	newvalue('SPECIFIED')
    end

    # Others are only blobs
    properties_ssl = [ \
	'ssl_cipher', \
	'x509_issuer', \
	'x509_subject' \
    ]
    properties_ssl.each { |property_ssl|
	newproperty(symbolize(property_ssl)) do
    	    desc "SSL " + property_ssl + ". Possible values are string or empty"
	    newvalue(/^.+$/)
	    newvalue(:empty)
	end
    }



    #
    # Numeric privilege properties
    #
    properties_max = [ \
	'max_questions', \
	'max_updates', \
	'max_connections', \
	'max_user_connections' \
    ]
    properties_max.each { |property_max|
	newproperty(symbolize(property_max), :boolean => true) do
    	    desc "Global " + property_max
	    newvalue(/^[0-9]{1,11}$/)
	end
    }
end
