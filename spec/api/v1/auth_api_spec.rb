require 'spec_helper'

describe Caminio::Sky::API::Auth do

  include Caminio::Sky

  let(:user){ create(:user) }

  it "Authenticates with @login and @password" do
    post '/api/v1/auth', login: user.username, password: user.password
    expect( last_response.status ).to be == 201
  end

  it "fails with wrong login" do
    post '/api/v1/auth', login: 'invalid', password: user.password
    expect( last_response.status ).to be == 401
  end

end
