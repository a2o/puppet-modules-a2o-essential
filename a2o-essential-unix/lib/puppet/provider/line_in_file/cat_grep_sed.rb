#
# Command line utility provider for managing lines in text files
#
# Author: Bostjan Skufca (bostjan {[A|T]} a2o.si)
#
Puppet::Type.type(:line_in_file).provide :cat_grep_sed, :parent => Puppet::Provider do



    #
    # Module description
    #
    desc "Shell provider for file_in_line management."



    #
    # Create generic resource methods
    #
    mk_resource_methods


    #
    # Prerequisites
    #
    commands :echo => "echo"
    commands :cat  => "cat"
    commands :grep => "grep"
    commands :sed  => "sed"



    #
    # Check if line already exists in file
    #
    def exists?
	#notice('PROVIDER METHOD: ' + __method__.id2name)

	# Check for all required stuff
	if @resource[:file].nil?
	    raise Puppet::Error, "Parameter 'file' is not defined"
	end
	if @resource[:line_regex].nil?
	    raise Puppet::Error, "Parameter 'line_regex' is not defined"
	end

	if @resource[:ensure] == :present
	    if @resource[:line].nil?
		raise Puppet::Error, "Parameter 'line' is not defined"
	    end

	    # Check if line matches line_regex
	    unless @resource[:line] =~ /^#{@resource[:line_regex]}$/
		raise Puppet::Error, "Parameter 'line_regex' does not match 'line' property"
	    end
	end

	# Does file exist? If not, create it
	unless FileTest.exists?(@resource[:file])
	    FileUtils.touch(@resource[:file])
	else
	    if FileTest.directory?(@resource[:file])
		raise Puppet::Error, "File is a directory: #{@resource[:file]}"
	    end
	end


	# Construct command
	lineRegexSh = get_shell_regex_format(@resource[:line_regex])
	cmd = "grep -E -c '^#{lineRegexSh}$' #{@resource[:file]}"

	# Execute and evaluate
	cmdOutput = `#{cmd}`
	if $? != 0
	    if cmdOutput.strip! == '0'
		return false
	    else
		raise Puppet::Error, "Exit status from grep is non-zero, but return value is not zero: #{cmdOutput.strip!}"
	    end
	else
	    # Can return whatever, only bool false is considered real false,
	    # everything else evaluates to true
	    return true
	end
    end



    #
    # Ensure line in file
    #
    def create
	#notice('PROVIDER METHOD: ' + __method__.id2name)

	# Set initial stuff
	tmpFile  = @resource[:file] + '.puppet.' + Process.pid.to_s + '.tmp'

	# Remove entries if requested
	if @resource[:remove_regex]
	    rmRegexSh = get_shell_regex_format(@resource[:remove_regex])

	    # Remove all instances first
	    execSimple("cat '#{@resource[:file]}' | grep -E -v '^#{rmRegexSh}$' > #{tmpFile}")

	    # Add desired line
	    execSimple("echo '#{@resource[:line]}' >> #{tmpFile}")

	    # Move to original location
	    execSimple("mv #{tmpFile} #{@resource[:file]}")
	else

	    # Add desired line
	    execSimple("echo '#{@resource[:line]}' >> #{@resource[:file]}")
	end

	# Return success
	return :present
    end



    #
    # Dummy method, create method takes care of everything about line creation
    #
    def line
	#notice('PROVIDER METHOD: ' + __method__.id2name)

	return @resource[:line]
    end



    #
    # Dummy method, create method takes care of everything
    #
    def remove_regex
	#notice('PROVIDER METHOD: ' + __method__.id2name)

	# Check if remove regex matches our line
	if @resource[:line] =~ /^#{@resource[:remove_regex]}$/
	    lineMatchesRemoveRegex = true
	else
	    lineMatchesRemoveRegex = false
	end

	# Set initial stuff
	rmRegexSh = get_shell_regex_format(@resource[:remove_regex])
	tmpFile  = @resource[:file] + '.puppet.' + Process.pid.to_s + '.tmp'

	# If line matches removeRegex, count occurences
	if lineMatchesRemoveRegex
	    cmd = "grep -E -c '^#{rmRegexSh}$' #{@resource[:file]}"
	    cmd_output = `#{cmd}`
	    ocCount = cmd_output.strip.to_i
	    if $? != 0
		if ocCount == 0
		    raise Puppet::Error, "No entries matching #{shRegex} found, but our line should already be there"
		else
		    raise Puppet::Error, "Exit status from grep is non-zero, but return value is not zero: #{cmd_output.strip!}"
		end
	    else
		if ocCount == 1
		    # Single instance, excellent
		    return @resource[:remove_regex]
		else
		    # Remove all instances first
		    execSimple("cat '#{@resource[:file]}' | grep -E -v '^#{rmRegexSh}$' > #{tmpFile}")

		    # Add desired line
		    execSimple("echo '#{@resource[:line]}' >> #{tmpFile}")

		    # Move to original location
		    execSimple("mv #{tmpFile} #{@resource[:file]}")

		    return @resource[:remove_regex]
		end
	    end
	end

	if !lineMatchesRemoveRegex
	    # Remove all instances
	    execSimple("cat '#{@resource[:file]}' | grep -E -v '^#{rmRegexSh}$' > #{tmpFile}")

	    # Move to original location
	    execSimple("mv #{tmpFile} #{@resource[:file]}")

	    return @resource[:remove_regex]
	end
    end



    #
    # Remove existing line from file
    #
    def destroy
	#notice('PROVIDER METHOD: ' + __method__.id2name)

	# If there is remove_regex defined, signal error
	if @resource[:remove_regex]
	    raise Puppet::Error, "When destroying resource, only line_regex is permitted to exist, not remove_regex also"
	end

	# Construct and execute modification
	lineRegexSh = get_shell_regex_format(@resource[:line_regex])
	tmpFile     = @resource[:file] + '.puppet.' + Process.pid.to_s + '.tmp'
	execSimple("cat '#{@resource[:file]}' | grep -E -v '^#{lineRegexSh}$' > #{tmpFile}")

	# Move to original location
	execSimple("mv #{tmpFile} #{@resource[:file]}")

	return @resource[:ensure]
    end



    #
    # Format normal regex into shell-compatible one
    #
    def get_shell_regex_format (origRegex)

	shellRegex1 = origRegex.sub("+", "\+")
	shellRegex2 = shellRegex1.sub("(", "\(")
	shellRegex3 = shellRegex2.sub("|", "\|")
	shellRegex4 = shellRegex3.sub(")", "\)")
	shellRegex  = shellRegex4

	return shellRegex
    end



    #
    # Execute simple command
    #
    def execSimple (cmd)

	cmdOutput = `#{cmd}`
	if $? != 0
	    raise Puppet::Error, "Execution failed: #{cmd}   #{cmdOutput}"
	end

	return cmdOutput.strip!
    end
end
