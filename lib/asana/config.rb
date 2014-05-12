require 'asana/version'

module Asana
  API_VERSION = '1.0'
  ENDPOINT    = "https://app.asana.com/api/#{API_VERSION}"
  USER_AGENT  = "asana-rest-client Ruby Gem (#{VERSION})"
end
