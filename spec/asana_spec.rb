require 'spec_helper'

describe Asana do

  it "sets configuration" do
    expect(Asana::API_VERSION).to eq('1.0')
    expect(Asana::ENDPOINT).to    eq("https://app.asana.com/api/1.0")
    expect(Asana::USER_AGENT).to  eq("asana-rest-client Ruby Gem (0.0.1)")
  end

end
