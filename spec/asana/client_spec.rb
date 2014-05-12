require 'spec_helper'
require 'base64'

describe Asana::Client do

  describe "#initialize" do
    it "requires either :api_token or :oauth_token to initialize" do
      expect {
        Asana::Client.new()
      }.to raise_error(ArgumentError)
    end

    it "only accepts one of :api_token or :oauth_token to initialize" do
      expect {
        Asana::Client.new(api_token: '1', oauth_token: '2')
      }.to raise_error(ArgumentError)
    end

    it "initializes when :api_token option is set" do
      client = Asana::Client.new(api_token: '1')
      expect(client.api_token).to     eq('1')
      expect(client.oauth_token).to   be_nil
    end

    it "initializes when :oauth_token option is set" do
      client = Asana::Client.new(oauth_token: '1')
      expect(client.oauth_token).to eq('1')
      expect(client.api_token).to   be_nil
    end
  end

  describe "#authorization_header" do
    it "sets Basic header for :api_token" do
      basic_header_value = Base64.encode64('1234:')

      client      = Asana::Client.new(api_token: '1234')
      auth_header = client.default_headers['Authorization']

      expect(auth_header).to eq("Basic #{basic_header_value}")
      
    end

    it "sets Bearer header for :oauth_token" do
      client      = Asana::Client.new(oauth_token: '1234')
      auth_header = client.default_headers['Authorization']
      expect(auth_header).to eq("Bearer 1234")
    end
  end

end

