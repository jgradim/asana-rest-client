require 'spec_helper'

describe Asana::Resources::Users do

  let!(:client){ Asana::Client.new(oauth_token: '1234') }

  describe '#user' do
    it "gets currently authenticated user" do
      VCR.use_cassette 'user_me' do
        expect(client.user(:me)['data']['email']).to eq('joao.gradim@gmail.com')
      end
    end

    it "gets arbitrary user authenticated user has access to" do
      VCR.use_cassette 'user_arbitrary' do
        expect(client.user('12149451952264')['data']['email']).to eq('joao.gradim@gmail.com')
      end
    end

    it "raises error when trying to access a non-existent user" do
      VCR.use_cassette 'user_nonexistent' do
        expect{ client.user('not-an-user-id') }.to raise_error Faraday::ClientError, /400/
      end
    end
  end

  describe '#users' do
    pending
  end

  describe '#users_in_workspace' do
    pending
  end

end
