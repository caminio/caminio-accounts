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

  describe "/users/:id" do

    before :each do
      @user = create(:user)
      @url = "/api/v1/users/#{@user.id}"
      header 'Authorization', "Bearer #{@user.create_access_token.token}"
    end

    it "returns a user json" do
      get @url
      expect( last_response.status ).to be == 200
      expect( json ).to have_key(:user)
    end

    describe "json return properties" do

      before :each do
        get "/api/v1/users/#{@user.id}"
      end

      it{ expect( json.user ).to have_key(:id) }
      it{ expect( json.user ).to have_key(:username) }
      it{ expect( json.user ).to have_key(:firstname) }
      it{ expect( json.user ).to have_key(:lastname) }
      it{ expect( json.user ).to have_key(:email) }
      it{ expect( json.user ).to have_key(:role) }
      it{ expect( json.user ).not_to have_key(:password_digest) }

    end

  end

  describe "/users/current" do

    before :each do
      @user = create(:user)
      header 'Authorization', "Bearer #{@user.create_access_token.token}"
      get '/api/v1/users/current'
    end

    it{ expect( json.user.id ).to be == @user.id }

  end

end
