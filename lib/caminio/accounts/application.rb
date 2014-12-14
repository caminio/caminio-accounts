require "yaml"
require "hashie"
require "active_record"
require "i18n"

class Caminio::Accounts::Application

  def self.config
    @@config
  end

  def initialize
    @config = Hashie::Mash.new
    db_config_file = Caminio::Accounts::Root.join( 'config', 'database.yml' )
    @config.db = Hashie::Mash.new YAML::load_file( db_config_file )[Caminio::Accounts::env]
    @@config = @config
    init_db
  end

  private

  def init_db
    ActiveRecord::Base.establish_connection( @config.db )
  end

end
