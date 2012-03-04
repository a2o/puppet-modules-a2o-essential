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
# Command line utility provider for managing MySQL users.
#
require 'puppet/provider/package'
require 'puppet/provider/mysql_cli_common'
Puppet::Type.type(:mysql_user).provide :mysql_cli, :parent => Puppet::Provider::Package do



    #
    # Include common routines and properties
    #
    include Puppet::Provider::Mysql_cli_common
    extend Puppet::Provider::Mysql_cli_common



    #
    # Module description
    #
    desc "MySQL CLI provider for user management."



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
        'User' \
    ]
    @system_columns          = Hash.new
    @system_column_positions = Hash.new



    #
    # Supported mysql.user table columns
    #
    @supported_priv_columns = [ \
        'Password', \
        'Select_priv', \
        'Insert_priv', \
        'Update_priv', \
        'Delete_priv', \
        'Create_priv', \
        'Drop_priv', \
        'Reload_priv', \
        'Shutdown_priv', \
        'Process_priv', \
        'File_priv', \
        'Grant_priv', \
        'References_priv', \
        'Index_priv', \
        'Alter_priv', \
        'Show_db_priv', \
        'Super_priv', \
        'Create_tmp_table_priv', \
        'Lock_tables_priv', \
        'Execute_priv', \
        'Repl_slave_priv', \
        'Repl_client_priv', \
        'Create_view_priv', \
        'Show_view_priv', \
        'Create_routine_priv', \
        'Alter_routine_priv', \
        'Create_user_priv', \
        'Event_priv', \
        'Trigger_priv', \
        'ssl_type', \
        'ssl_cipher', \
        'x509_issuer', \
        'x509_subject', \
        'max_questions', \
        'max_updates', \
        'max_connections', \
        'max_user_connections' \
    ]



    #
    # Tolerated mysql.user table columns - present here to omit warnings in logs
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
    # Retrieve list of existing users
    #
    def self.instances
        debug('PROVIDER METHOD: ' + __method__.id2name)

	sql = "SELECT * FROM user"
	outputRaw = self.execSQL(sql, true)

	# Loop through output
        users = []
        output_position = -1
	outputRaw.split(/\n/).each   do   |line_raw|

            output_position += 1

            # Remove trailing newline
            line = line_raw.chomp

            # Do we parse the header or the content?
            if output_position == 0
                self.parse_available_columns(line)
            else
                user = parse_object_privileges('user', line)
                users << new(user)
            end
        end

        return users
    end



    #
    # Create new user
    #
    def create
        debug('PROVIDER METHOD: ' + __method__.id2name)
	am_i_functional?

        # Get username and hostname
        user = get_resource_username
        host = get_resource_hostname

        # Check if password is present
        unless password = @resource[:password]
            resource.fail("You MUST specify a password if you want to create a new MySQL user")
        end

        # Construct SQL statement command to create user
        sql = "CREATE USER '#{user}'@'#{host}' IDENTIFIED BY PASSWORD '#{password}'"
	execSQL(sql)

	# Check if some global privileges/options were given
	managed_privileges = Hash.new
	self.class.usable_priv_columns.each { |column, position|
	    if value = @resource[symbolize(column.downcase)]
		managed_privileges[column] = value
	    end
	}

	# Update user if there are some changes - at least password is always present
	if managed_privileges.size > 0
	    update_user(user, host, managed_privileges)
	end
    end



    #
    # Remove existing user
    #
    def destroy
        debug('PROVIDER METHOD: ' + __method__.id2name)
	am_i_functional?

        # Get username and hostname
        user = get_resource_username
        host = get_resource_hostname

        # Construct SQL statement command to remove user
        sql = "DROP USER '#{user}'@'#{host}'"
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
            update_user(user, host, property_changes)
        end

	# Call parent method
	super
    end



    #
    # Updates the mysql.user table for a given user and FLUSHes PRIVILEGES.
    #
    def update_user (user, host, new_values)
        debug('PROVIDER METHOD: ' + __method__.id2name)

        # Construct SQL statement to enforce changes
        sql = "UPDATE user SET "
        new_values.each do |field, value|
            field_mysql = self.class.convert_to_mysql_field(field)
            value_mysql = self.class.convert_to_mysql_value(value)
	    if value_mysql == :empty
        	sql = sql + "#{field_mysql}='', "
	    else
        	sql = sql + "#{field_mysql}='#{value_mysql}', "
	    end
        end
        sql = sql.slice(0, sql.size-2)   # Removes trailing comma and space
        sql = sql + " WHERE User='#{user}' AND Host='#{host}'"

        # Execute it
	execSQL(sql)

        # Flush privileges
        sql = "FLUSH PRIVILEGES"
	execSQL(sql)
    end



    #
    # Split name into username and hostname part - get username
    #
    def get_resource_username

        # Split the name into username and hostname
        unless @resource[:name] =~ /^([^@]+)@(.+)$/
            raise Puppet::Error, "Invalid name (user@host required)"
        end
	return $1
    end



    #
    # Split name into username and hostname part - get hostname
    #
    def get_resource_hostname

        # Split the name into username and hostname
        unless @resource[:name] =~ /^([^@]+)@(.+)$/
            raise Puppet::Error, "Invalid name (user@host required)"
        end
	return $2
    end
end
