ENV['RACK_ENV'] = 'test'
require 'simplecov'
SimpleCov.start

require 'bundler/setup'
require 'rack/test'
Bundler.setup

require 'caminio/sky'
Caminio::Sky::init

require 'active_record'
ActiveRecord::Migrator.up 'db/migrate'
# ActiveRecord::Base.logger = Logger.new(STDOUT)

require 'factory_girl'
Dir.glob("#{File::expand_path '../factories', __FILE__}/*.rb").each do |file|
  require file
end

module RspecHelper
  module CaminioSkyHelper

    def app
      Caminio::Sky::API::Root
    end

  end
end

RSpec.configure do |config|

  config.mock_with :rspec
  config.color = true
  config.tty = true
  config.fail_fast = true
  config.formatter = :documentation # :progress, :html, :textmate
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include RspecHelper::CaminioSkyHelper
  config.include Rack::Test::Methods
  config.include FactoryGirl::Syntax::Methods

  # config.before(:suite) do
  # end

end
