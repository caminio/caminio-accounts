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

    it { expect(user.update( username: 'test2' )).to be_a(Caminio::Sky::User) }
    it { expect(Caminio::Sky::User.first( username: 'test2' )).not_to be(nil) }
    it { expect(Caminio::Sky::User.first( username: 'test-update' )).to be(nil) }

  end

  describe "delete" do

    let(:user){ create(:user, username: 'test-delete') }

    it { expect(user.destroy).to be_a(Caminio::Sky::User) }
    it { expect(Caminio::Sky::User.first( username: 'test-delete')).to be(nil) }
  end

end
