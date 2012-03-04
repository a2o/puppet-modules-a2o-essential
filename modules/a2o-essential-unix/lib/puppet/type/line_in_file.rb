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
# Type for managing simple text files.
#
Puppet::Type.newtype :line_in_file do



    #
    # Type documentation.
    #
    @doc = "Simple text file manipulation resource. Manipulates only single line at once."



    # FIXME autorequire file?



    #
    # The resource can be created and destroyed
    #
    ensurable



    #
    # Parameter: name
    #
    newparam(:name, :namevar => true) do
	desc "The identifier of line in file"
    end



    #
    # Parameter: file
    #
    newparam(:file) do
    	desc "File to ensure line in"
    end



    #
    # Parameter: line_regex
    #
    newparam(:line_regex) do
    	desc "Regular expression to check for line presence."
	desc "Starting and ending anchors are added implicitly"
    end



    #
    # Property: line
    #
    newproperty(:line) do
    	desc "Line to ensure"
	newvalue(/^.+$/)
    end



    #
    # Property: remove_regex
    #
    newproperty(:remove_regex) do
    	desc "Which entries to replace with this resource"
	newvalue(/^.+$/)
    end
end
