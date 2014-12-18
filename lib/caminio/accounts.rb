require "grape"
require "active_record"
require "active_model_serializers"
require 'grape-active_model_serializers'

require "caminio/accounts/version"
require "caminio/accounts/env"
require "caminio/accounts/root"
require "caminio/accounts/application"

# disable annoying active record message
I18n.enforce_available_locales = false

module Caminio::Accounts

  # define API for app/api files to be loaded in load_app_files
  module API
  end

  def self.init
    @@app = Application.new
    self.load_app_files
  end

  def self.load_app_files
    dir = File::expand_path '../../../app', __FILE__
    Dir.glob( "#{dir}/{helpers,api,models,serializers}/**/*.rb" ).each do |file|
      require file
    end
    require "#{dir}/api"
  end

end
