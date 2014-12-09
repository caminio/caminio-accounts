require 'spec_helper'

describe Caminio::Sky::API::Users do

  before :all do
    @url = '/api/v1/users'
    @user = create(:user)
    @token = @user.create_access_token
  end

  it "requires authentication" do
    get @url
    expect(last_response).not_to be_ok
  end

  # it "passes with valid access_token" do
  #   get @url, {}, Authorization: "Bearer #{@token.token}"
  #   expect(last_response).to be_ok
  # end

end
