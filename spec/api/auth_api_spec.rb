require 'spec_helper'

describe Caminio::Sky::API::Auth do

  it "Authenticates with @login and @password" do
    post '/auth', login: 'auth-test-username', password: 'auth-test-password'
    expect( last_response.status ).to be == 201
  end

end
