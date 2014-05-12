module Asana
  module Resources
    module Users

      # Gets an user
      #
      # @see http://developer.asana.com/documentation/#users
      # 
      # @return [Hash] Requested user fields
      #
      # @param id [String] A numeric user id or 'me' for the currently authenticated user
      # @param options [Hash] Customizable set of options
      def user(id, options = {})
        request(:get, "users/#{id}", options)
      end

      # Gets all users across all workspaces authenticated user has access to
      #
      # @see http://developer.asana.com/documentation/#users
      # 
      # @return [Array] All other users authenticated user can see
      #
      # @param options [Hash] Customizable set of options
      def users(options = {})
        request(:get, 'users', options = {})
      end


      # Gets all users in workspaces
      #
      # @see http://developer.asana.com/documentation/#users
      # 
      # @return [Array] All other users authenticated user can see
      #
      # @param workspace_id [String] workspace id
      # @param options [Hash] Customizable set of options
      def users_in_workspace(workspace_id, options = {})
        request(:get, "/workspaces/#{workspace_id}/users")
      end

    end
  end
end
