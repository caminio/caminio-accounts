ENV['RACK_ENV'] = 'test'
require 'bundler/setup'
require 'rack/test'
Bundler.setup

require 'caminio/sky'
Caminio::Sky::init

module RspecHelper
  module CaminioSkyHelper

    def cleanup
      db_file = File::join('..','db','test.sqlite3')
      return unless File::exists? db_file
      File::delete db_file
    end

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

end
