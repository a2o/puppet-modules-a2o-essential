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
#
# Common subroutines for command line utility provider for managing MySQL objects.
#
module Puppet::Provider::Mysql_cli_common



    #
    # Module description
    #
    # MySQL object management provider common subroutines
    #
    # It assumes 'mysql' command is in your path.
    # It also assumes that the user running Puppet has homedir in /root.
    # It tries to use one of two credential files specified below, in 
    # given order:
    #   /root/.my.cnf.puppet
    #	/root/.my.cnf
    # These 2 files are tried every time a command fails with authorization 
    # error. If none provides sufficient credentials to connect to DB, 
    # exception is raised.
    #
    # Example of content in these files:
    #   [client]
    #   host     = localhost
    #   user     = root
    #   password = YOUR_ROOT_PASSWORD



    #
    # Credentials files
    #
    @@credentials_files = [ \
        '/root/.my.cnf.puppet', \
        '/root/.my.cnf' \
    ]
    @@credentials_file_to_use = ''



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
    # Populate @usable_priv_columns and @usable_priv_column_positions
    #
    # Parses the header line from 'SELECT * FROM user' SQL statement
    # Expects this header line without leading or trailing spaces, 
    # items separated only by tabs.
    #
    # At the end it also checks if all system columns have been detected.
    #
    def parse_available_columns (header_line)

        # Prepare the hashes
        rsc = Hash.new
        spc = Hash.new
        tpc = Hash.new
        @required_system_columns.each { |column|
            rsc[column] = -1
        }
        @supported_priv_columns.each { |column|
            spc[column] = -1
        }
        @tolerated_priv_columns.each { |column|
            tpc[column] = -1
        }

        # Split the line by tabs
        items = header_line.split(%r{\t})

        # Now loop through the column name list
        position = -1
        items.each { |item|
            position = position + 1

	    # Is it a supported privilege column?
	    if spc[item]
                @usable_priv_columns[item] = position
	        @usable_priv_column_positions[position] = item
		next
	    end

	    # Is it a system column?
	    if rsc[item]
		@system_columns[item] = position
		@system_column_positions[position] = item
		next
	    end

	    # Is it a tolerated privilege column?
	    if tpc[item]
                @tolerated_priv_column_positions[position] = item
		next
	    end

	    # Privilege is not supported at all
            warning("Privilege column from mysql.user table not supported nor tolerated: #{item}")
        }

	# Check if all system columns have been recognised
	@required_system_columns.each { |column_name|
	    unless @system_columns[column_name]
		raise Puppet::Error, "System column #{column_name} not found."
	    end
	}
    end



    #
    # Parse object privileges
    #
    def parse_object_privileges (object_type, object_line)

        # Split the line by tabs
        items = object_line.split(%r{\t})

        # New object hashes
        sys    = Hash.new
        object = Hash.new

        # Now loop through the column name list
        position = -1
        items.each { |item|
            position = position + 1

	    # Is it an usable privilege column?
            if @usable_priv_column_positions[position]
        	column = symbolize(@usable_priv_column_positions[position].downcase)
        	object[column] = self.convert_from_mysql_value(item)
		next
	    end

	    # Is it a system column?
	    if @system_column_positions[position]
        	column = symbolize(@system_column_positions[position].downcase)
        	sys[column] = item
		next
	    end

            # Is it a tolerated column?
            if @tolerated_priv_column_positions[position]
		next
	    end

	    # Privilege is not supported at all
            warning("Privilege column from mysql privilege table not supported nor tolerated: #{item}")
        }

	case object_type
	    when 'user'
    		object[:name] = sys[:user] + '@' + sys[:host]
	    when 'db_grant'
    		object[:name] = sys[:user] + '@' + sys[:host] + '/' + sys[:db]
	    else
		raise Puppet::Error, "Object type unknown: #{object_type}"
	end
        object[:ensure] = :present
        return object
    end



    #
    # Getter for usable privileges, required for creating new users
    #
    def usable_priv_columns
	return @usable_priv_columns
    end



    #
    # Instance constructor
    #
    def initialize (resource)
	#debug('PROVIDER METHOD: ' + __method__.id2name)

        # First we call the parent constructor
        super(resource)

        # Then we store the original properties
        @property_hash_original = Hash.new
        @property_hash.each do |key, value|
            @property_hash_original[key] = value
        end
    end



    #
    # Check if object exists
    #
    def exists?
        #debug('PROVIDER METHOD: ' + __method__.id2name)
	am_i_functional?

	if @property_hash.size == 0
	    return false
	else
	    return true
	end
    end



    #
    # Below here are some helper methods for both class and instance access
    #



    #
    # Convert to values appropriate for Puppet
    #
    def convert_from_mysql_value (value)
        if value == 'Y'
            return :true
        elsif value == 'N'
            return :false
        elsif value == ''
	    return :empty
        else
            return value
        end
    end



    #
    # Convert to values appropriate for MySQL
    #
    def convert_to_mysql_value (value)
        if value == :true
            return 'Y'
        elsif value == :false
            return 'N'
	elsif value == :empty
	    return :empty
        else
            return value
        end
    end



    #
    # Convert field names (uppercase first character where necessary)
    #
    def convert_to_mysql_field (field)
        fieldStr = field.to_s
        if fieldStr =~ /(^password|_priv)$/
            return fieldStr.capitalize
        else
            return fieldStr
        end
    end



    #
    # Execute SQL command
    #
    def execSQL (sql, include_headers=false)

	if @@credentials_file_to_use == ''
	    self.select_credentials_file
	end
	used_credentials_file = @@credentials_file_to_use

	# 1st try
	if include_headers == false
	    cmd_add = " --skip-column-names "
	else
	    cmd_add = ""
	end
	cmd = "echo \"#{sql}\" | #{command(:mysql)} --defaults-file=#{used_credentials_file} --batch --database=mysql #{cmd_add} 2>&1"
	debug(cmd)
        output = `#{cmd}`
        if $?.to_i == 0
	    return output
	end

	# Is it authentication error?
	if output =~ /Access denied for user/
	    self.select_credentials_file
	    if @@credentials_file_to_use == used_credentials_file
		raise Puppet::Error, "Error executing command #{cmd}: #{output}"
	    end
	else
	    raise Puppet::Error, "Error executing command #{cmd}: #{output}"
        end

	# 2nd try
	cmd = "echo \"#{sql}\" | #{command(:mysql)} --defaults-file=#{used_credentials_file} --batch --database=mysql #{cmd_add} 2>&1"
	debug(cmd)
        output = `#{cmd}`
        if $?.to_i == 0
	    return output
	else
	    raise Puppet::Error, "Error executing command #{cmd}: #{output}"
	end
    end



    #
    # Select applicable credentials file
    #
    def select_credentials_file

	@@credentials_files.each   do   |credentials_file|
    	    sql = 'SELECT * FROM user LIMIT 1'
    	    cmd = "echo \"#{sql}\" | #{command(:mysql)} --defaults-file=#{credentials_file} " + \
		    " --batch --skip-column-names --database=mysql 2>&1"
    	    output = `#{cmd}`
    	    if $?.to_i == 0
		@@credentials_file_to_use = credentials_file
		return
	    end
	end

	raise Puppet::Error, "No appropriate credentials file found (checked " + @@credentials_files.join(':') + ")"
    end



    #
    # Is provider for resource functional?
    #
    def am_i_functional?
	if @@credentials_file_to_use == ''
	    raise Puppet::Error, "Provider not functional, credentials file not selected"
	end
    end
end
