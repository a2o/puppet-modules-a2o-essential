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
Puppet::Type.type(:service).provide :a2o_linux_rctool do
    desc "a2o_linux_rctool service management support."



    #
    # Feature list
    #
    has_feature :enableable



    #
    # Command definitions
    #
    commands :bash   => 'bash'
    # FIXME TODO
    #commands :rctool => 'rctool'



    #
    # Start the service
    #
    def start

	rcName = getRctoolName(@resource[:name])

	if @resource[:start]
	    `#{@resource[:start]}`
	elsif doesRctoolCommandExist
	    `rctool #{rcName} start`
	else
	    `bash /etc/rc.d/rc.#{rcName} start`
	end

	serviceStatus = $?

	unless serviceStatus == 0
            raise Puppet::Error, "ERROR: Unable to start service #{rcName}"
	end
    end



    #
    # Restart the service
    #
    def restart

	rcName = getRctoolName(@resource[:name])

	if @resource[:restart]
	    `#{@resource[:restart]}`
	elsif doesRctoolCommandExist
	    `rctool #{rcName} restart`
	else
	    `bash /etc/rc.d/rc.#{rcName} restart`
	end

	serviceStatus = $?

	unless serviceStatus == 0
            raise Puppet::Error, "ERROR: Unable to restart service #{rcName}"
	end
    end



    #
    # Stop the service
    #
    def stop

	rcName = getRctoolName(@resource[:name])

	if @resource[:stop]
	    `bash #{@resource[:stop]}`
	elsif doesRctoolCommandExist
	    `rctool #{rcName} stop`
	else
	    `bash /etc/rc.d/rc.#{rcName} stop`
	end

	serviceStatus = $?

	unless serviceStatus == 0
            raise Puppet::Error, "ERROR: Unable to stop service #{rcName}"
	end
    end



    #
    # Get service status
    #
    def status

	rcName = getRctoolName(@resource[:name])

        # Check if exists at all
	unless File.exists?("/etc/rc.d/rc." + rcName)
	    return :unknown
	end
	unless File.executable?("/etc/rc.d/rc." + rcName)
	    return :disabled
	end

	# Get status by appropriate means
	if @resource[:status]
	    `bash #{@resource[:status]}`
	elsif doesRctoolCommandExist
	    `rctool #{rcName} status`
	else
	    `bash /etc/rc.d/rc.#{rcName} status`
	end

	# Evaluate result
	serviceStatus = $?
	if serviceStatus == 0
	    return :running
	elsif serviceStatus == 256
	    return :stopped
	else
            raise Puppet::Error, "ERROR: Unable to get service status for #{rcName}"
	end
    end



    #
    # Is service enabled at startup
    #
    def enabled?

	rcName = getRctoolName(@resource[:name])

	unless File.exists?("/etc/rc.d/rc." + rcName)
	    return :false
	end

	if File.executable?("/etc/rc.d/rc." + rcName)
	    return :true
	else
	    return :false
	end
    end



    #
    # Enable service at startup
    #
    def enable

	rcName = getRctoolName(@resource[:name])

	unless File.exists?("/etc/rc.d/rc." + rcName)
            raise Puppet::Error, "ERROR: Service management script not found: /etc/rc.d/rc.#{rcName}"
	end
	File.chmod(0755, "/etc/rc.d/rc." + rcName)
    end



    #
    # Disable service at startup
    #
    def disable

	rcName = getRctoolName(@resource[:name])

	# First stop the service
	stop

	if File.exists?("/etc/rc.d/rc." + rcName)
	    File.chmod(0644, "/etc/rc.d/rc." + rcName)
	end
    end



    #
    # Get clean name of a service
    #
    def getRctoolName (nameDirty)

	regex = %r{^a2o(-essential)?-linux-}
	if match = regex.match(nameDirty)
    	    rcName = match.post_match
	else
    	    rcName = @resource[:name]
	end

	return rcName
    end



    #
    # Check if /bin/rctool command exists
    #
    def doesRctoolCommandExist
	if File.exists?("/bin/rctool") and File.executable("/bin/rctool")
	    return true
	else
	    return false
	end
    end
end
