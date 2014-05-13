module Asana
  module Resources
    module Stories

      def story(id, options = {})
        request(:get, "stories/#{id}", options)
      end

    end
  end
end
