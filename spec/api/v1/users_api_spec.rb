require 'spec_helper'

describe Caminio::Sky::API::Users do

  it "requires authentication" do
    get '/api/v1/users'
    expect(last_response).not_to be_ok
  end

end
