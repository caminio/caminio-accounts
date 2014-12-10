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

  describe "POST /users" do

    before :each do
      @admin = create(:user, role: 'admin')
      header 'Authorization', "Bearer #{@admin.create_access_token.token}"
    end

    let(:url){ '/api/v1/users' }
    let(:error_400){ 'user is missing, user[email] is missing' }
    let(:post_attr){ { user: { email: 'test@example.com', username: 'test' } } }

    describe "requires" do

      it { post(url); expect( last_response.status ).to be == 400 }

      it { post(url); expect( json.error ).to be == error_400 }

      it { post(url, { user: { } } ); expect( json.error ).to be == error_400 }

    end

    describe "returns user" do
      
      before :each do
        post url, post_attr 
      end

      it{ expect( last_response.status ).to be == 201 }

      it{ expect( json ).to have_key :user }

    end

    describe "no organization" do

      before :each do 
        post url, post_attr
      end

      it{ expect( json.user.organization_ids.size ).to be == 0 }

    end

    describe "with organization" do

      before :each do
        @org = Caminio::Sky::Organization.create name: 'test-org'
        post url, user: { email: 'test@example.com', organization_id: @org.id }
      end

      it { expect( json.user.organization_ids.size ).to be == 1 }

    end

  end

  describe "PUT /:id" do

    before :each do
      @admin = create(:user, role: 'admin')
      @user = create(:user)
      header 'Authorization', "Bearer #{@admin.create_access_token.token}"
    end

    describe "update" do

      let(:url){ "/api/v1/users/#{@user.id}" }

      describe "email" do

        before :each do
          put url, { user: { email: 'new@example.com' } }
        end

        it { expect( json.user.email ).to eq('new@example.com') }

      end

    end

  end

  describe "DELETE /:id" do

    before :each do
      @admin = create(:user, role: 'admin')
      @user = create(:user)
      header 'Authorization', "Bearer #{@admin.create_access_token.token}"
      delete "/api/v1/users/#{@user.id}"
    end

    it{ expect( last_response.status ).to be == 200 }
    it{ expect( json ).to eq({}) }

  end

end
