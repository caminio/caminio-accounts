ENV['RACK_ENV'] = 'test'
require 'bundler/setup'
Bundler.setup

require 'fileutils'

require 'caminio/sky'
Caminio::Sky::init

module RspecHelper
  module CaminioSkyHelper

    def cleanup
      puts Caminio::Root.join('db')
      # FileUtils::rm_rf spec_git_path
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

end
