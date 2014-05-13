module Asana
  module Resources
    module Attachments

      def attachment(id, options = {})
        request(:get, "attachments/#{id}", options)
      end

    end
  end
end
