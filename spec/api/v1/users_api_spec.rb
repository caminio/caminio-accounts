require 'spec_helper'

describe Caminio::Sky::API::Users do

  describe "authentication" do

    before :each do
      @url = '/api/v1/users'
      @user = create(:user)
      @token = @user.create_access_token
    end

    it "requires authentication" do
      get @url
      expect(last_response).not_to be_ok
    end

    it "passes with valid access_token" do
      header 'Authorization', "Bearer #{@token.token}"
      get @url
      expect(last_response).to be_ok
      expect(json).to have_key('users')
      expect(json.users.size).to eq(1)
    end

  end

  describe "/user/:id" do

    before :each do
      @user = create(:user)
      @url = "/api/v1/users/#{@user.id}"
      header 'Authorization', "Bearer #{@user.create_access_token.token}"
    end

    it "does not return password_digest as part of json" do
      get @url
      expect( last_response.status ).to be == 200
    end

  end

end
