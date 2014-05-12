module Asana
  module Resources
    module Subtasks

      def subtasks(task_id, options = {})
        request(:get, "tasks/#{task_id}/subtasks")
      end

      def create_subtask_in_task(task_id, options = {})
        request(:post, "tasks/#{task_id}/subtasks")
      end
      
      def set_task_parent(task_id, parent_id, options = {})
        options.reverse_merge!(params: { parent_id: parent_id })
        request(:post, "tasks/#{task_id}/setParent", options)
      end

    end
  end
end
