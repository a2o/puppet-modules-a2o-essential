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
	else
	    `rctool #{rcName} start`
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
	else
	    `rctool #{rcName} restart`
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
	else
	    `rctool #{rcName} stop`
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
	else
	    `rctool #{rcName} status`
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

	regex = %r{^a2o-linux-}
	if match = regex.match(nameDirty)
    	    rcName = match.post_match
	else
    	    rcName = @resource[:name]
	end

	return rcName
    end
end
