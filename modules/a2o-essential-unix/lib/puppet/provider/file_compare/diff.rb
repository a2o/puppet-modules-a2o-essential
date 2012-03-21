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
# Command line utility provider for comparing text files
#
Puppet::Type.type(:file_compare).provide :diff, :parent => Puppet::Provider do



    #
    # Module description
    #
    desc "Shell provider for file_compare."



    #
    # Create generic resource methods
    #
    mk_resource_methods


    #
    # Prerequisites
    #
    commands :diff => "diff"



    #
    # Compare files and fail the resource if differences are found
    #
    def compare_to

	# Execute
	cmd    = "diff -u #{@resource[:name]} #{@resource[:compare_to]}"
	output = `#{cmd}`

	# Evaluate
	case $?
	    when 0
		return @resource[:compare_to]
	    when 1, 256
		@resource.fail "File difference found!\nFile 1: #{@resource[:name]}\nFile 2: #{@resource[:compare_to]}\nDiff:\n'#{output}'"
	    else
		raise Puppet::Error, "Execution failed (#{$?})!\nCommand: #{cmd}\nOutput:  #{output}"
	end
    end
end
