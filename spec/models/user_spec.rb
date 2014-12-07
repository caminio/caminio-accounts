require 'spec_helper'

describe Caminio::Sky::User do

  before :all do
    cleanup
  end

  describe "create" do

    before :all do
      @user = Caminio::Sky::User.create username: 'test'
    end

    it { expect(@user).to be_a(Caminio::Sky::User) }
    it { expect(@user.username).to eq('test') }
    it { expect(Caminio::Sky::User.where( username: 'test' ).first ).not_to be(nil) }
    it { expect(Caminio::Sky::User.where( username: 'test' ).first ).to be_a(Caminio::Sky::User) }

  end

  describe "update" do

    before :all do
      @user = Caminio::Sky::User.create username: 'test-update'
    end

    it { expect(@user.update( username: 'test2' )).to be_a(Caminio::Sky::User) }
    it { expect(Caminio::Sky::User.first( username: 'test2' )).not_to be(nil) }
    it { expect(Caminio::Sky::User.first( username: 'test-update' )).to be(nil) }

  end

  describe "delete" do

    before :all do
      @user = Caminio::Sky::User.create username: 'test-delete'
    end

    it { expect(@user.destroy).to be_a(Caminio::Sky::User) }
    it { expect(Caminio::Sky::User.first( username: 'test-delete')).to be(nil) }
  end

end
