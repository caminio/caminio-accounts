require "caminio/sky/version"
require "caminio/sky/env"
require "caminio/sky/root"
require "caminio/sky/application"
require "caminio/sky/migration"

module Caminio::Sky

  # define API for app/api files to be loaded in load_app_files
  module API
  end

  def self.init
    @@app = Application.new
    self.run_migrations
    self.load_app_files
  end

  def self.register_model( model )
    @@models ||= []
    @@models << model
  end

  def self.registered_models
    @@models ||= []
  end

  def self.run_migrations
    dir = File::expand_path '../../../db/migrations', __FILE__
    Dir.glob( "#{dir}/*.rb" ).each do |file|
      require file
    end
  end

  def self.load_app_files
    dir = File::expand_path '../../../app', __FILE__
    Dir.glob( "#{dir}/{helpers,api,models}/**/*.rb" ).each do |file|
      next if File::basename(file) == 'root.rb'
      require file
      load file if File::basename(File::dirname(file)) == 'models'
    end
    require "#{dir}/api/root"
  end

end
