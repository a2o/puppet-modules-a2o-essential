#
# Command line utility provider for managing MySQL databases.
#
# Author: Bostjan Skufca (bostjan {[A|T]} a2o.si)
#


require 'puppet/provider/package'
require 'puppet/provider/mysql_cli_common'
Puppet::Type.type(:mysql_database).provide :mysql_cli, :parent => Puppet::Provider::Package do



    #
    # Include common routines and properties
    #
    include Puppet::Provider::Mysql_cli_common
    extend Puppet::Provider::Mysql_cli_common



    #
    # Module description
    #
    desc "MySQL CLI provider for database management."



    #
    # Prerequisites
    #
    commands :mysql => "mysql"
    commands :echo  => "echo"



    #
    # Retrieve list of existing databases
    #
    def self.instances
	debug('PROVIDER METHOD: ' + __method__.id2name)

	sql = "SHOW DATABASES"
	outputRaw = self.execSQL(sql, true)

	# Loop through output
        databases = []
	outputRaw.split(/\n/).each   do   |line_raw|

            # Remove trailing newline
            line = line_raw.chomp

            database = Hash.new
            database[:name]   = line.chomp
            database[:ensure] = :present
            databases << new(database)
        end

        return databases
    end



    #
    # Instance constructor
    #
    def initialize (resource)
	super(resource)
    end



    #
    # Create a new database
    #
    def create
	debug('PROVIDER METHOD: ' + __method__.id2name)

	sql = "CREATE DATABASE #{@resource[:name]}"
        execSQL(sql)
    end



    #
    # Remove existing database
    #
    def destroy
	debug('PROVIDER METHOD: ' + __method__.id2name)

        # Check if there are some tables left in the database
        if @resource[:force] != :true
	    sql = "USE #{@resource[:name]}; SHOW TABLES"
    	    output = execSQL(sql)

    	    # If tables are still in the database, force parameter must be present to allow the removal
    	    if output != ''
                resource.fail("ERROR: Use force=>true parameter to remove non-empty database.")
            end
        end

        # Now remove the database
	sql = "DROP DATABASE #{@resource[:name]}"
        execSQL(sql)
    end
end
