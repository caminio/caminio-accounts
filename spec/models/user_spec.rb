require 'spec_helper'

describe Caminio::Sky::User do

  describe "create" do
  
    let(:user){ create(:user) }

    it { expect(user).to be_a(Caminio::Sky::User) }
    it { expect(user.username).to eq('johndoe') }
    it { expect(Caminio::Sky::User.where( username: 'johndoe' ).first ).not_to be(nil) }
    it { expect(Caminio::Sky::User.where( username: 'johndoe' ).first ).to be_a(Caminio::Sky::User) }

  end

  describe "update" do

    let(:user){ create(:user, username: 'test-update') }

    it { expect(user.update( username: 'test2' )).to be(true) }
    it { expect(Caminio::Sky::User.find_by( username: 'test2' )).not_to be(nil) }
    it { expect(Caminio::Sky::User.find_by( username: 'test-update' )).to be(nil) }

  end

  describe "delete" do

    let(:user){ create(:user, username: 'test-delete') }

    it { expect(user.destroy).to be_a(Caminio::Sky::User) }
    it { expect(Caminio::Sky::User.find_by( username: 'test-delete')).to be(nil) }
  end

  describe "access_token" do

    let(:user){ create(:user) }

    describe "creates a new access token" do
      
      let(:access_token){ user.aquire_access_token }

      it { expect( access_token ).to be_a(Caminio::Sky::AccessToken) }

      it { expect( access_token.token.size ).to eq(32) }

      it { expect( access_token.expires_at ).to be >= (8*60-1).minutes.from_now }

      it { expect( access_token.expires_at ).to be <= (8*60+1).minutes.from_now }

      describe "invalidates old access_token if new is aquired" do

        let(:new_token){ user.aquire_access_token }

        it { expect( new_token.id ).not_to eq( access_token.id ) }

        # it { expect( Caminio::Sky::AccessToken.find( access_token.id ) ).to be(nil) }

      end

    end


  end

end
