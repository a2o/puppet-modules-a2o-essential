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
# Below is the original comment from the originating source of this file:
# URI: https://github.com/example42/puppi/blob/master/lib/puppet/parser/functions/params_lookup.rb
#
# It has been adapted to better suit a2o puppet environment.
#
###########################################################################
#
# params_lookup.rb
#
# This function lookups for a variable value in various locations
# following this order
# - Hiera backend, if present
# - ::varname (if second argument is 'global')
# - ::modulename_varname
# - ::modulename::params::varname
#
# It's based on a suggestion of Dan Bode on how to better manage
# Example42 NextGen modules params lookups.
# Major help has been given by  Brice Figureau, Peter Meier
# and Ohad Levy during the Fosdem 2012 days (thanks guys)
#
# Tested and adapted to Puppet 2.6.x and later
#
# Alessandro Franceschi al@lab42.it
#
###########################################################################

module Puppet::Parser::Functions
  newfunction(:a2o_get_param, :type => :rvalue, :doc => <<-EOS
This fuction looks for the given variable name in a set of sources, in the following order:
- Hiera, if available (if second argument is 'global')
- Hiera, if available ('modulename_varname')
- Hiera, if available ('modulename(no _essential_ string included)_varname')
- ::varname (if second argument is 'global')
- ::modulename_varname
- ::modulename(no _essential_ string included)_varname
- ::modulename::params::varname
If no value is found in the defined sources, this functions throws an error.

Example:
* Class name is "a2o_essential_linux_bind"
* Variable names is "chroot_dir"
Order of searched variables is as follows (the first one encountered is returned):
- hiera: searching for variable "a2o_essential_linux_bind_chroot_dir"
- hiera: searching for variable "a2o_linux_bind_chroot_dir" (no '_essential_')
- hiera: searching for variable "chroot_dir", if second argument is 'global'
- top scope: searching for variable "::a2o_essential_linux_bind_chroot_dir"
- top scope: searching for variable "::a2o_linux_bind_chroot_dir" (no '_essential_')
- top scope: searching for variable "::chroot_dir", if second argument is 'global'
- ::a2o_essential_linux_bind::params::chroot_dir

WARNING: Hiera part is currently disabled.

EOS
  ) do |arguments|


    # Require at least one paramenter
    raise(Puppet::ParseError, "a2o_getparam(): Parameter name is required, " +
	"'global' as second argument is optional"
    ) if arguments.size < 1


    # Init values to operati with
    value       = ''
    var_name    = arguments[0]
    module_name = parent_module_name
    if module_name =~ /_essential_/
	module_name_short = $` + '_' + $'
    else
	module_name_short = module_name
    end


    ### Hiera Lookup
    if Puppet::Parser::Functions.function('hiera')

	# TODO remove when tested
	raise Puppet::ParseError, "Hiera is currently untested and thus disabled with this error"

	# Try long module name first
	value = function_hiera(["#{module_name}_#{var_name}", ''])
	return value if (not value.nil?) && (value != :undefined) && (value != '')

	# Then short variation
	value = function_hiera(["#{module_name_short}_#{var_name}", ''])
	return value if (not value.nil?) && (value != :undefined) && (value != '')

	# Trg non-module-prefixed variable if global keyword has been given
	value = function_hiera(["#{var_name}", '']) if arguments[1] == 'global'
    end # Hiera available?


    ### Node Variables Lookup
    value = lookupvar("#{module_name}_#{var_name}")
    return value if (not value.nil?) && (value != :undefined) && (value != '')

    value = lookupvar("#{module_name_short}_#{var_name}")
    return value if (not value.nil?) && (value != :undefined) && (value != '')


    ### Various scope lookups - THINK should this be removed? Normally all these things are defined in node definition.
    # Top Scope Variable Lookup (::module_name_varname)
    value = lookupvar("::#{module_name}_#{var_name}")
    return value if (not value.nil?) && (value != :undefined) && (value != '')

    # Top Scope Variable Lookup (::module_name_short_varname)
    value = lookupvar("::#{module_name_short}_#{var_name}")
    return value if (not value.nil?) && (value != :undefined) && (value != '')

    # Look up ::varname (only if second argument is 'global')
    if arguments[1] == 'global'
	value = lookupvar("::#{var_name}")
	return value if (not value.nil?) && (value != :undefined) && (value != '')
    end

    # Needed for the next two lookups
    classname = self.resource.name.downcase
    loaded_classes = catalog.classes

    # self::params class lookup for default value
    if loaded_classes.include?("#{classname}::params")
	value = lookupvar("::#{classname}::params::#{var_name}")
	return value if (not value.nil?) && (value != :undefined) && (value != '')
    end

    # Params class lookup for default value
    if loaded_classes.include?("#{module_name}::params")
	value = lookupvar("::#{module_name}::params::#{var_name}")
	return value if (not value.nil?) && (value != :undefined) && (value != '')
    end

    raise(Puppet::ParseError, "Argument not defined: #{module_name}::#{var_name}")

  end # newfunction
end # Module
