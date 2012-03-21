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
# Command line utility provider for managing MySQL database grants.
#
require 'puppet/provider/package'
require 'puppet/provider/mysql_cli_common'
Puppet::Type.type(:mysql_grant_db).provide :mysql_cli, :parent => Puppet::Provider::Package do



    #
    # Include common routines and properties
    #
    include Puppet::Provider::Mysql_cli_common
    extend Puppet::Provider::Mysql_cli_common



    #
    # Module description
    #
    desc "MySQL CLI provider for database privilege management."



    #
    # Prerequisites
    #
    commands :mysql => "mysql"
    commands :echo  => "echo"



    #
    # Create generic resource methods
    #
    mk_resource_methods



    #
    # System privilege columns from mysql.user table, from which :name is later derived
    #
    @required_system_columns = [ \
        'Host', \
        'User', \
        'Db' \
    ]
    @system_columns          = Hash.new
    @system_column_positions = Hash.new



    #
    # Supported mysql.db table columns
    #
    @supported_priv_columns = [ \
        'Select_priv', \
        'Insert_priv', \
        'Update_priv', \
        'Delete_priv', \
        'Create_priv', \
        'Drop_priv', \
        'Grant_priv', \
        'References_priv', \
        'Index_priv', \
        'Alter_priv', \
        'Create_tmp_table_priv', \
        'Lock_tables_priv', \
        'Create_view_priv', \
        'Show_view_priv', \
        'Create_routine_priv', \
        'Alter_routine_priv', \
        'Execute_priv', \
        'Event_priv', \
        'Trigger_priv' \
    ]



    #
    # Tolerated mysql.db table columns - present here to omit warnings in logs
    #
    # Privilege columns which may exists on server (as of MySQL 5.1.48) but are not 
    # used by this provider
    #
    @tolerated_priv_columns = []
    @tolerated_priv_column_positions = Hash.new



    #
    # Usable privilege columns:
    #
    # Must be:
    # - supported by this provider
    # - available on the server
    #
    # In form: column_name => position in mysql.user table
    # In form: position => column_name
    #
    @usable_priv_columns          = Hash.new
    @usable_priv_column_positions = Hash.new



    #
    # Retrieve list of existing database grants
    #
    def self.instances
        debug('PROVIDER METHOD: ' + __method__.id2name)

        sql = "SELECT * FROM db"
	outputRaw = self.execSQL(sql, true)

        # Loop through output
        db_grants = []
        output_position = -1
        outputRaw.split(/\n/).each   do   |line_raw|

            output_position += 1

            # Remove trailing newline
            line = line_raw.chomp

            # Do we parse the header or the content?
            if output_position == 0
                self.parse_available_columns(line)
            else
                db_grant = parse_object_privileges('db_grant', line)
                db_grants << new(db_grant)
            end
        end

        return db_grants
    end



    #
    # Create new database grant
    #
    def create
        debug('PROVIDER METHOD: ' + __method__.id2name)
	am_i_functional?

        # Get username, hostname and database name
        user = get_resource_username
        host = get_resource_hostname
        db   = get_resource_database

        # Construct SQL statement command to create db grant
        sql = "INSERT INTO db SET User='#{user}', Host='#{host}', Db='#{db}'"
	execSQL(sql)

	# Check if some global privileges/options were given
	managed_privileges = Hash.new
	self.class.usable_priv_columns.each { |column, position|
	    if value = @resource[symbolize(column.downcase)]
		managed_privileges[column] = value
	    end
	}

	# Update database grant if there are some changes
	if managed_privileges.size > 0
	    update_db_grant(user, host, db, managed_privileges)
	end
    end



    #
    # Remove existing database grant
    #
    def destroy
        debug('PROVIDER METHOD: ' + __method__.id2name)
	am_i_functional?

        # Get username and hostname
        user = get_resource_username
        host = get_resource_hostname
        db   = get_resource_database

        # Construct SQL statement command to remove user
        sql = "DELETE FROM db WHERE User='#{user}' AND Host='#{host}' AND Db='#{db}'"
	execSQL(sql)
    end



    #
    # Flush the changes to environment
    #
    # This method is the work horse of this provider. First it discovers the 
    # differences between previous and current state, then constructs
    # appropriate SQL statement, then executes it and at the end also 
    # FLUSHes PRIVILEGES.
    #
    def flush
        debug('PROVIDER METHOD: ' + __method__.id2name)
	am_i_functional?

        # Get username and hostname
        user = get_resource_username
        host = get_resource_hostname
        db   = get_resource_database

        # Check which properties were changed
        property_changes = Hash.new
        @property_hash.each do |key, value|
            if value != @property_hash_original[key]
                property_changes[key] = value
            end
        end

        # If there are some changes, enforce them. Otherwise skip, an user was 
	# added or something.
        if property_changes.size > 0
            update_db_grant(user, host, db, property_changes)
        end

	# Call parent method
	super
    end



    #
    # Updates the mysql.db table for a given user and FLUSHes PRIVILEGES.
    #
    def update_db_grant (user, host, db, new_values)
        debug('PROVIDER METHOD: ' + __method__.id2name)

        # Construct SQL statement to enforce changes
        sql = "UPDATE db SET "
        new_values.each do |field, value|
            field_mysql = self.class.convert_to_mysql_field(field)
            value_mysql = self.class.convert_to_mysql_value(value)
            sql = sql + "#{field_mysql}='#{value_mysql}', "
        end
        sql = sql.slice(0, sql.size-2)   # Removes trailing comma and space
        sql = sql + " WHERE User='#{user}' AND Host='#{host}' AND Db='#{db}'"

        # Execute it
	execSQL(sql)

        # Flush privileges
        sql = "FLUSH PRIVILEGES"
	execSQL(sql)
    end



    #
    # Split name into username and hostname and database part - get username
    #
    def get_resource_username

        unless @resource[:name] =~ /^([^@]+)@(.+)\/(.+)$/
            raise Puppet::Error, "Invalid name (user@host/db required)"
        end
	return $1
    end



    #
    # Split name into username and hostname and database part - get hostname
    #
    def get_resource_hostname

        unless @resource[:name] =~ /^([^@]+)@(.+)\/(.+)$/
            raise Puppet::Error, "Invalid name (user@host/db required)"
        end
	return $2
    end



    #
    # Split name into username and hostname and database part - get database
    #
    def get_resource_database

        unless @resource[:name] =~ /^([^@]+)@(.+)\/(.+)$/
            raise Puppet::Error, "Invalid name (user@host/db required)"
        end
	return $3
    end
end
