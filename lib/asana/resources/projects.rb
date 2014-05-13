module Asana
  module Resources
    module Projects

      def projects(options = {})
        request(:get, "projects", options)
      end

      def projects_in_workspace(workspace_id, options = {})
        request(:get, "workspaces/#{workspace_id}/projects", options)
      end

      def project(id, options = {})
        request(:get, "projects/#{id}", options)
      end

      def create_project(options = {})
        request(:post, "projects", options)
      end

      def create_project_in_workspace(workspace_id, options = {})
        request(:post, "workspaces/#{workspace_id}/projects", options)
      end

      def update_project(id, options = {})
        request(:put, "projects/#{id}", options)
      end

      def delete_project(id, options = {})
        request(:delete, "projects/#{id}")
      end

    end
  end
end
