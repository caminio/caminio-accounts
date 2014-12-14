require 'spec_helper'

describe Caminio::Accounts::Application do

  it "Application root" do
    expect( Caminio::Accounts::Root.join ).to eq( File::join(Dir.pwd,'') )
  end

  it "reads configuration" do
    expect( Caminio::Accounts::Application.config ).to have_key(:db)
  end

  it "initializes with correct env" do
    expect( Caminio::Accounts::env ).to eq('test')
  end

end
