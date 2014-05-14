require 'faraday'
require 'faraday_middleware'

require 'asana/error'

module Asana
  module Response
    class RaiseError < Faraday::Response::Middleware

      def on_complete(response)
        status = response[:status].to_i
        raise Asana::Error.from_response(response) if status.between?(400,600)
      end

    end
  end
end

Faraday::Response.register_middleware :raise_asana_error => Asana::Response::RaiseError
