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
# Returns current module name
#
module Puppet::Parser::Functions
    newfunction(:a2o_get_current_module_name, :type => :rvalue, :doc => <<-EOS
This fuction returns current module name.
EOS
    ) do |arguments|

	return parent_module_name

    end # newfunction
end # Module