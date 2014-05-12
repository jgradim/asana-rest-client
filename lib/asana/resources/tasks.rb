module Asana
  module Resources
    module Tasks

      def task(id, options = {})
        request(:get, "tasks/#{id}", options)
      end

      def tasks(options = {})
        request(:get, 'tasks', options)
      end

      def tasks_in_project(project_id, options = {})
        request(:get, "projects/#{project_id}/tasks", options)
      end

      def tasks_in_workspace(workspace_id, options = {})
        request(:get, "workspaces/#{workspace_id}/tasks", options)
      end

      # Every task is required to be created in a specific workspace, and
      # this workspace cannot be changed once set. The workspace need not be
      # set explicitly if you specify a parent task instead.
      #
      # http://developer.asana.com/documentation/#tasks
      def create_task(options = {})
        request(:post, "tasks", options)
      end

      def create_task_in_workspace(workspace_id, options = {})
        request(:post, "workspaces/#{workspace_id}/tasks", options)
      end

      #
      def update_task(id, options = {})
        request(:put, "tasks/#{id}", options)
      end

      def delete_task(id, options = {})
        request(:delete, "tasks/#{id}", options)
      end

    end
  end
end
