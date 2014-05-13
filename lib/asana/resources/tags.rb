module Asana
  module Resources
    module Tags

      def tags(options = {})
        request(:get, "tags", options)
      end

      def tags_in_workspace(workspace_id, options = {})
        request(:get, "workspaces/#{workspace_id}/tags", options)
      end

      def tag_tasks(id, options = {})
        request(:get, "tags/#{id}/tasks")
      end

      def tag(id, options = {})
        request(:get, "tags/#{id}", options)
      end

      def create_tag(options = {})
        request(:post, "tags", options)
      end

      def create_tag_in_workspace(workspace_id, options = {})
        request(:post, "workspaces/#{workspace_id}/tags", options)
      end

      def update_tag(id, options = {})
        request(:put, "tags/#{id}", options)
      end

      def delete_tag(id, options = {})
        request(:delete, "tags/#{id}")
      end

    end
  end
end
