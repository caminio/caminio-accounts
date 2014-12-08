ENV['RACK_ENV'] = 'test'
require 'bundler/setup'
require 'rack/test'
Bundler.setup

db_file = File::join( File::expand_path('../../db/test.sqlite3', __FILE__) )
puts "db file is #{db_file}"
File::delete db_file if File::exists? db_file

require 'caminio/sky'
Caminio::Sky::init

require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

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

  config.before(:suite) do
    begin
      DatabaseCleaner.start
      FactoryGirl.lint
    ensure
      DatabaseCleaner.clean
    end
  end

end
