require 'faraday'
require 'faraday_middleware'
require 'base64'

require 'asana/api'

module Asana
  class Client
    include Asana::API

    attr_accessor :api_token
    attr_accessor :oauth_token

    def initialize(options = {})
      @options     = options
      @api_token   = options[:api_token]
      @oauth_token = options[:oauth_token]

      raise ArgumentError.new(":api_token or :oauth_token option required") if @api_token.nil? && @oauth_token.nil?
      raise ArgumentError.new("only one of :api_token or :oauth_token options allowed") if @api_token && @oauth_token

      self
    end

    def request(method, path, options = {})
      response = connection.public_send(method) do |request|
        request.url path
        request.headers.update(default_headers)
      end

      response.body
    rescue Faraday::TimeoutError, Timeout::Error => error
      raise Asana::Error::RequestTimeout.new(error.message)
    rescue JSON::ParserError => error
      # TODO
    end

    def default_headers
      @default_headers ||= {
        'Content-Type'  => 'application/json',
        'Accept'        => 'application/json',
        'User-Agent'    => USER_AGENT,
        'Authorization' => authorization_header
      }
    end

    private

    def connection(options = {})
      @connection ||= Faraday.new(url: ENDPOINT) do |conn|
        conn.response :json
        conn.response :logger
        conn.response :raise_asana_error

        conn.adapter  Faraday.default_adapter
      end
    end

    def authorization_header
      if @api_token
        encoded_api_token = Base64.encode64 "#{@api_token}:"
        "Basic #{encoded_api_token}"
      elsif @oauth_token
        "Bearer #{@oauth_token}"
      end
    end

  end
end
