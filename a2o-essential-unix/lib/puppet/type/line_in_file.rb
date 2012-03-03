#
# Type for managing simple text files.
#
# Author: Bostjan Skufca (bostjan {[A|T]} a2o.si)
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
