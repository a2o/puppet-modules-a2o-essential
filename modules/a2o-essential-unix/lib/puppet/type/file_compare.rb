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
# Simple text file comparison resource.
#
Puppet::Type.newtype :file_compare do



    #
    # Type documentation.
    #
    @doc = "Simple text file comparison resource. Emits warning if there are differences."



    # FIXME autorequire file?



    #
    # Parameter: name
    #
    newparam(:name, :namevar => true) do
	desc "Original file"
    end



    #
    # Parameter: compare_to
    #
    newproperty(:compare_to) do
    	desc "File to compare namevar file to, with desired content"
    end
end
