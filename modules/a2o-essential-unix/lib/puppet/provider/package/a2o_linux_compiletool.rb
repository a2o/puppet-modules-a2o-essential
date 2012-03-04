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
require 'puppet/provider/package'
Puppet::Type.type(:package).provide :a2o_linux_compiletool, :source => :sh, :parent => Puppet::Provider::Package do

    #
    # Packaging tool description
    #
    desc "a2o_linux_compiletool packaging support."



    #
    # Packaging tool features
    #
    has_feature :versionable



    #
    # Command definitions
    #
    commands :bash       => 'bash'
    commands :ls         => 'ls'
    commands :mv         => 'mv'
    commands :rm         => 'rm'
    commands :mkdir      => 'mkdir'
    commands :rmdir      => 'rmdir'
    commands :wget       => 'wget'



    #
    # Get all installed packages
    #
    def self.instances
	debug('PROVIDER METHOD: ' + __method__.id2name)

	# Empty package set
        packages = Array.new

        begin
	    # If directory does not exist there are no packages on the system
	    # THINK what if it is currently only missing? Maybe /var is not mounted
	    if not File.exists?('/var/log/packages_compiled')
		if not File.exists?('/var/log')
		    raise Puppet::Error, "Directory /var/log does not exist"
		else
		    warning("Directory /var/log/packages_compiled does not exist")
		    return packages
		end
	    end

	    # List out all of the packages
            execpipe("ls /var/log/packages_compiled --sort=v | grep -v '\\.log$'| cat") { |output|

                # now turn each returned line into a package hash
                output.each { |line|
		    lineStripped = line.strip
    		    package = Hash.new
            	    regex = %r{-([a-zA-Z0-9\._]+)-([a-zA-Z0-9\._]+)$}

            	    if match = regex.match(lineStripped)
            		package[:name]     = match.pre_match
            		package[:version]  = match[1]
            		package[:release]  = match[2]
    			package[:ensure]   = "#{package[:version]}-#{package[:release]}"
            		package[:instance] = lineStripped
            	    else
        		raise Puppet::Error, "Failed to match line #{lineStripped}"
            	    end
                    packages << new(package)

		    # Support for multiple versions of the same package
		    # Just add another package with full package tag as package name
    		    packageMulti = Hash.new
		    packageMulti[:name]     = lineStripped
            	    packageMulti[:version]  = match[1]
            	    packageMulti[:release]  = match[2]
    		    packageMulti[:ensure]   = "#{packageMulti[:version]}-#{packageMulti[:release]}"
    		    packageMulti[:instance] = lineStripped + "-" + packageMulti[:ensure]
                    packages << new(packageMulti)
                }
            }
        rescue Puppet::ExecutionFailure
            raise Puppet::Error, "Failed to list packages"
        end

        return packages
    end



    #
    # Find the fully versioned package name and the version alone. Returns
    # a hash with entries 
    # - :instance => fully versioned package name, and 
    # - :ensure   => version-release
    #
    def query

	# Parse out the package name
	regex = %r{^a2o-linux-}
	if match = regex.match(@resource[:name])
	    name = match.post_match
	else
	    name = @resource[:name]
	    #
	    # Old behaviour
	    # raise Puppet::Error, "a2o_linux_compiletool package name must be prefixed with 'a2o-linux-'"
	end

	# Check the array for this instance
	instanceLatest = nil
	self.class.instances.each do |instance|
	    if instance.name == name
		instanceLatest = instance
		if instance.properties[:ensure] == @resource[:ensure]
		    return instance.properties
		end
	    end
	end

	if instanceLatest != nil
	    return instanceLatest.properties
	end

	return nil
    end



    #
    # Install a package
    #
    def install
        compileScript = nil
        unless compileScript = @resource[:source]
            @resource.fail "a2o_linux_compiletool needs a compile script path (via 'source' parameter)"
        end

	# Support for multiple versions of the same package,
	# Please do notice workaround in instances method
	resourceEnsure = @resource[:ensure]
	regex = %r{-#{Regexp.escape(resourceEnsure)}$}
	if match = regex.match(@resource[:name])
	    packageTag = @resource[:name]
	else
	    packageTag = @resource[:name] + "-" + @resource[:ensure]
	end

	logFile = "/var/log/packages_compiled/#{packageTag}.log"
	statusFile = "/var/log/packages_compiled/#{packageTag}"

	notice("Compiling and installing #{packageTag}... ")
	`bash #{compileScript} > #{logFile} 2>&1`
	unless $? == 0
	    @resource.fail "ERROR: Compilation and installation of #{packageTag} FAILED"
	end

	`mv #{logFile} #{statusFile}`
	unless $? == 0
	    @resource.fail "ERROR: Unable to move #{logFile} to #{statusFile}"
	end

	notice("...done.")
	return nil
    end


end
