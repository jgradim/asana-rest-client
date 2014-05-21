require 'base64'

require 'faraday'
require 'faraday_middleware'
require 'hashie'

require 'asana/utils'
require 'asana/api'
require 'asana/response/raise_error'

module Asana
  class Client
    include Asana::Utils
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
      headers = options[:headers] || {}
      params  = options[:params]  || {}

      response = connection.public_send(method, path, params) do |request|
        request.headers.update(default_headers)
        request.headers.update(headers)
      end

      clear_rate_limit

      response.body
    rescue Asana::Error::RateLimitReached => error
      set_rate_limit(error)
      raise error
    rescue Faraday::Error::TimeoutError, Timeout::Error => error
      raise Asana::Error::RequestTimeout.new(error.message)
    end

    def default_headers
      @default_headers ||= {
        'Content-Type'  => 'application/json',
        'Accept'        => 'application/json',
        'User-Agent'    => USER_AGENT,
        'Authorization' => authorization_header
      }
    end

    def rate_limit
      {
        retry_after: @retry_after,
        resets_at:   @resets_at
      }
    end

    private

    def connection(options = {})
      @connection ||= Faraday.new(url: ENDPOINT) do |conn|
        conn.response :mashify
        conn.response :json
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

    def clear_rate_limit
      @retry_after = nil
      @resets_at   = nil
    end

    def set_rate_limit(error)
      @retry_after = error.retry_after.to_i rescue 0
      @resets_at   = Time.at(Time.now.to_i + Time.at(@retry_after).to_i)
    end

  end
end
