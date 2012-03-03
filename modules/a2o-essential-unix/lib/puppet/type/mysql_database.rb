#
# Type for managing MySQL databases.
#
# Author: Bostjan Skufca (bostjan {[A|T]} a2o.si)
#
Puppet::Type.newtype :mysql_database do



    #
    # Type documentation.
    #
    @doc = "MySQL database management. Creates or drops databases."



    #
    # The resource can be created and destroyed
    #
    ensurable



    #
    # Database name
    #
    newparam(:name) do
	desc "The name of the database. Can only contain alphanumeric characters and an underscore."
	newvalues(/^[a-zA-Z0-9_]{1,64}$/)
    end



    #
    # Force the removal
    #
    newparam(:force, :boolean => true) do
        desc "Force the database operation. Only used when removing non-empty databases."
        newvalues(:true, :false)
        defaultto false
    end
end
