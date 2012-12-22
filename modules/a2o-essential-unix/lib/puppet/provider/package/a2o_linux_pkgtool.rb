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
require 'puppet/provider/package'
Puppet::Type.type(:package).provide :a2o_linux_pkgtool, :source => :tgz, :parent => Puppet::Provider::Package do

    #
    # Packaging tool description
    #
    desc "a2o_linux_pkgtool packaging support. Should work with Slackwarea."



    #
    # Packaging tool features
    #
    has_feature :versionable



    #
    # Command definitions
    #
    commands :mkdir      => 'mkdir'
    commands :rm         => 'rm'
    commands :rmdir      => 'rmdir'
    commands :wget       => 'wget'
    commands :installpkg => 'installpkg'



    #
    # Get all installed packages
    #
    def self.instances
        packages = Array.new

        # list out all of the packages
        begin
            execpipe("ls /var/log/packages | grep '^[^-]\\+-[^-]\\+-[^-]\\+' | sort") { |output|

                # now turn each returned line into a package hash
                output.each { |line|
		    lineStripped = line.strip
    		    package = Hash.new
            	    regex = %r{-([a-zA-Z0-9\._]+)-([a-zA-Z0-9\._]+)-([_a-zA-Z0-9]+)$}

            	    if match = regex.match(lineStripped)
            		package[:instance] = lineStripped
            		package[:name]     = match.pre_match
            		package[:version]  = match[1]
            		package[:arch]     = match[2]
            		package[:release]  = match[3]
    			package[:ensure]   = "#{package[:version]}-#{package[:arch]}-#{package[:release]}"
            	    else
        		raise Puppet::Error, "Failed to match line #{lineStripped}"
            	    end
                    packages << new(package)

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
    # - :ensure   => version-arch-release
    #
    def query
	# Parse out the package name
	regex = %r{^a2o-linux-}
	if match = regex.match(@resource[:name])
	    name = match.post_match
	else
	    raise Puppet::Error, "a2o-linux-pkgtool package name must be prefixed with 'a2o-linux-'"
	end

	# Check the array for this instance
	self.class.instances.each do |instance|
	    if instance.name == name
		return instance.properties
	    end
	end

	return nil
    end


    #
    # Install a package
    #
    def install
        sourceUri = nil
        unless sourceUri = @resource[:source]
            @resource.fail "a2o-linux-pkgtool requires a package source URI"
        end

	packageDir  = '/var/src/a2o-linux-pkgtool'
	packageFile = packageDir + '/' + File.basename(sourceUri)
	packageName = File.basename(sourceUri, '.tgz')
	packageName = File.basename(sourceUri, '.txz')

	notice("Installing #{packageName}...")
	`mkdir -p #{packageDir}`
	`rm -f #{packageFile}`

	`wget -O #{packageFile} --max-redirect 0 -q #{sourceUri}`
	unless $? == 0
	    @resource.fail "ERROR: Download from #{sourceUri} FAILED"
	end

#	`installpkg #{packageFile} 1>&2`
	`installpkg #{packageFile}`
	unless $? == 0
	    @resource.fail "ERROR: Install from #{packageFile} FAILED"
	end

	`rm #{packageFile}`
	notice("...done.")
    end
end

