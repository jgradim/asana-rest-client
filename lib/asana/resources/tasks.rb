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

      #------------------------------------------------------------------------
      # Task Activity / Comments (Stories)
      #------------------------------------------------------------------------

      def task_stories(id, options = {})
        request(:get, "tasks/#{id}/stories", options)
      end

      def comment_on_task(id, options = {})
        request(:post, "tasks/#{id}/stories", options)
      end

      #------------------------------------------------------------------------
      # Task Projects
      #------------------------------------------------------------------------

      def task_projects(id, options = {})
        request(:get, "tasks/#{id}/projects")
      end

      def add_task_to_project(id, project_id, options = {})
        options = set_param(options, :project, project_id)
        request(:post, "tasks/#{id}/addProject", options)
      end

      def remove_task_from_project(id, project_id, options = {})
        options = set_param(options, :project, project_id)
        request(:post, "tasks/#{id}/removeProject", options)
      end

      #------------------------------------------------------------------------
      # Task Tags
      #------------------------------------------------------------------------

      def task_tags(id, options = {})
        request(:get, "tasks/#{id}/tags")
      end

      def add_tag_to_task(id, tag_id, options = {})
        options = set_param(options, :tag, tag_id)
        request(:post, "tasks/#{id}/addTag", options)
      end

      def remove_tag_from_task(id, tag_id, options = {})
        options = set_param(options, :tag, tag_id)
        request(:post, "tasks/#{id}/removeTag", options)
      end

      #------------------------------------------------------------------------
      # Task Followers
      #------------------------------------------------------------------------

      def add_followers_to_task(id, followers, options = {})
        options = set_param(options, :followers, followers)
        request(:post, "tasks/#{id}/addFollowers", options)
      end

      def remove_followers_from_task(id, followers, options = {})
        options = set_param(options, :followers, followers)
        request(:post, "tasks/#{id}/removeFollowers", options)
      end

      #------------------------------------------------------------------------
      # Task Attachments
      #------------------------------------------------------------------------

      def task_attachments(id, options = {})
        request(:get, "tasks/#{id}/attachments", options)
      end

      def add_attachment_to_task(id, options = {})
        #upload_request(:post, "tasks/#{id}/attachments", options)
      end

    end
  end
end
