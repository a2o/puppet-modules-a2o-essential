#
# Command line utility provider for comparing text files
#
# Author: Bostjan Skufca (bostjan {[A|T]} a2o.si)
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
