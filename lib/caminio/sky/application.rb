require "yaml"
require "hashie"
require "sequel"

class Caminio::Sky::Application

  def self.config
    @@config
  end

  def initialize
    @config = Hashie::Mash.new
    db_config_file = Caminio::Sky::Root.join( 'config', 'database.yml' )
    @config.db = Hashie::Mash.new YAML::load_file( db_config_file )[Caminio::Sky::env]
    @@config = @config
    init_db
  end

  private

  def init_db
    Sequel::Model.plugin(:schema)
    Sequel::Model.db = Sequel.sqlite( @config.db.database )
    puts "db is #{@config.db.database}"
  end

end
