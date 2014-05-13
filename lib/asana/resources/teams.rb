module Asana
  module Resources
    module Teams

      def teams_in_organization(organization_id, options = {})
        request(:get, "organizations/#{organization_id}/teams", options)
      end

    end
  end
end
