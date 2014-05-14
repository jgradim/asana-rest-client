module Asana

  class Error < StandardError
    attr_reader :code, :rate_limit

    class << self

      # Create a new error from an HTTP response
      #
      # @param response [Faraday::Response]
      # @return [Twitter::Error]
      def from_response(response)
        status, message = response[:status].to_i, parse_error(response)
        klass = errors[status] || Asana::Error
        klass.new(message)
      end

      def parse_error(response)
        body = if response[:body].is_a?(String)
                 JSON.parse(response[:body])
               elsif response[:body].is_a?(Hash)
                 response[:body]
               end

        error_messages = body['errors'].map{ |error| error['message'] }

        ([response[:status]] + error_messages).join("\n")
      end

      def errors
        @errors ||= {
          400 => Asana::Error::BadRequest,
          401 => Asana::Error::Unauthorized,
          403 => Asana::Error::Forbidden,
          404 => Asana::Error::NotFound,
          429 => Asana::Error::RateLimitReached, # 100 reqs/min
          500 => Asana::Error::ServerError
        }
      end

    end # class << self

    class BadRequest < self; end
    class Unauthorized < self; end
    class Forbidden < self; end
    class NotFound < self; end
    class RateLimitReached < self; end
    class ServerError < self; end

    class RequestTimeout < self; end

  end

end
