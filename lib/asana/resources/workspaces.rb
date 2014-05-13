module Asana
  module Resources
    module Workspaces

      def workspaces(options = {})
        request(:get, "workspaces", options)
      end

      def update_workspace(id, options = {})
        request(:put, "workspaces/#{id}", options)
      end

    end
  end
end
