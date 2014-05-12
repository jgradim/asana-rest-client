require 'asana/resources/users'
#require 'asana/resources/tasks'
#require 'asana/resources/projects'
#require 'asana/resources/tags'
#require 'asana/resources/stories'
#require 'asana/resources/workspaces'
#require 'asana/resources/teams'
#require 'asana/resources/attachments'

module Asana
  module API

    include Asana::Resources::Users
    #include Asana::Resources::Tasks
    #include Asana::Resources::Projects
    #include Asana::Resources::Tags
    #include Asana::Resources::Stories
    #include Asana::Resources::Workspaces
    #include Asana::Resources::Teams
    #include Asana::Resources::Attachments

  end
end
