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

  describe "#default_headers" do
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

  describe "#request" do
    let!(:client){ Asana::Client.new(oauth_token: '1234') }
  end

  describe "#set_param" do
    let!(:client) { Asana::Client.new(oauth_token: '1234') }

    it "correctly sets param values on empty options hash" do
      options = client.set_param({}, :a, 1)
      expect(options).to eq({params: { a: 1} })
    end

    it "correctly sets values on populated options hash" do
      options = {
        params:  { a: 1, b: 2 },
        headers: { 'User-Agent' => 'user-agent' }
      }

      options = client.set_param(options, :c, 3)

      expect(options).to eq({
        params:  { a: 1, b: 2, c: 3 },
        headers: { 'User-Agent' => 'user-agent' }
      })
    end

    it "does not override already set param values" do
      options = {
        params:  { a: 1, b: 2 },
        headers: { 'User-Agent' => 'user-agent' }
      }

      options = client.set_param(options, :b, 3)

      expect(options).to eq({
        params:  { a: 1, b: 2 },
        headers: { 'User-Agent' => 'user-agent' }
      })
    end

  end

end

