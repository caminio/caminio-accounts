require 'spec_helper'

describe Caminio::Sky::Application do

  it "Application root" do
    expect( Caminio::Sky::Root.join ).to eq( File::join(Dir.pwd,'') )
  end

  it "reads configuration" do
    expect( Caminio::Sky::Application.config ).to have_key(:db)
  end

  it "initializes with correct env" do
    expect( Caminio::Sky::env ).to eq('test')
  end

end
