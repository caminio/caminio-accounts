require 'spec_helper'

describe Caminio::Sky::User do

  describe "create" do
  
    let!(:user){ create(:user) }

    it { expect(user).to be_a(Caminio::Sky::User) }
    it { expect(user.username).to eq('johndoe') }
    it { expect(Caminio::Sky::User.where( username: 'johndoe' ).first ).not_to be(nil) }
    it { expect(Caminio::Sky::User.where( username: 'johndoe' ).first ).to be_a(Caminio::Sky::User) }

  end

  describe "update" do

    let!(:user) do
      user = create(:user, username: 'test-update')
      user.update( username: 'test2' )
      user
    end

    it { expect(Caminio::Sky::User.find_by( username: 'test2' )).not_to be(nil) }
    it { expect(Caminio::Sky::User.find_by( username: 'test-update' )).to be(nil) }

  end

  describe "delete" do

    let!(:user) do
      user = create(:user, username: 'test-delete')
      user.destroy
    end

    it { expect(Caminio::Sky::User.find_by( username: 'test-delete')).to be(nil) }

  end

  describe "access_token" do

    let!(:user){ create(:user) }

    describe "creates a new access token" do
      
      let!(:access_token){ user.aquire_access_token }

      it { expect( access_token ).to be_a(Caminio::Sky::AccessToken) }

      it { expect( access_token.token.size ).to eq(32) }

      it { expect( access_token.expires_at ).to be >= (8*60-1).minutes.from_now }

      it { expect( access_token.expires_at ).to be <= (8*60+1).minutes.from_now }

      describe "invalidates old access_token if new is aquired" do

        it "only finds one valid token" do
          new_token = user.aquire_access_token
          expect( new_token.id ).not_to eq( access_token.id )
          expect( Caminio::Sky::AccessToken.find_by( id: access_token.id ) ).to be(nil)
        end

      end

    end


  end

  describe "roles" do

    let!(:user){ create(:user) }

    describe "defaults to user" do
    
      it{ expect( user.role ).to eq('user') }

    end

    describe "is_admin?" do

      let!(:admin){ create(:user, role: 'admin') }

      it{ expect( user.is_admin? ).to be false }

      it{ expect( admin.is_admin? ).to be true }

    end

  end

  describe "locale" do

    let!(:user){ create(:user) }
    it{ expect( user.locale ).to eq I18n.default_locale.to_s }

  end

end
