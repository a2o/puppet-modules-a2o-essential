#
# Simple text file comparison resource.
#
# Author: Bostjan Skufca (bostjan {[A|T]} a2o.si)
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
