require "caminio/accounts/version"
require "rake"
require "rake/tasklib"

module Caminio
  module Accounts
    class RakeTask < ::Rake::TaskLib
      # List of sprocket file targets that
      # should be compiled.
      attr_accessor :assets

      # List of source directories. This is a convenience
      # method as it will add all available sub-directories
      # like `stylesheets`, `javascripts` to Accounts
      # include path.
      #
      # Example: If you have a typical Accounts directory
      # layout like `src/assets/stylesheets`,
      # `src/assets/javascripts` all you need to add to
      # `source` is `src/assets`.
      attr_accessor :sources

      # Set output directory. Defaults to `dist` in current
      # working directory.
      attr_accessor :output

      # If assets should include digest. Default is false.
      attr_accessor :digest

      # If assets should be compressed. Default is false.
      attr_accessor :compress

      # `Environment` instance used for finding assets.
      attr_accessor :environment

      def index
        @index ||= environment.index if environment
      end

      def manifest
        @manifest ||= Accounts::Standalone::Manifest.new index, File.join(output, "manifest.json")
      end

      def initialize(*args)
        @namespace   = args.shift || :caminio
        @assets      = %w(application.js application.css *.png *.jpg *.gif)
        @sources     = []
        @output      = File.expand_path('dist', Dir.pwd)
        @digest      = false
        @compress    = false

        @environment = Accounts::Environment.new(Dir.pwd) do |env|
          env.logger = Logger.new $stdout
          env.logger.level = Logger::INFO
        end

        yield self, environment if block_given?

        Array(sources).each { |source| environment.append_path source }

        manifest.compress_assets = !!@compress
        manifest.digest_assets   = !!@digest

        namespace @namespace do
          desc 'run database migrations'
          task :migrate do
            manifest.migrate
          end
        end
      end
    end

    class Manifest < ::Accounts::Manifest

      def create_database config
        options = {:charset => 'utf8', :collation => 'utf8_unicode_ci'}

        create_db = lambda do |config|
          ActiveRecord::Base.establish_connection config.merge('database' => nil)
          ActiveRecord::Base.connection.create_database config['database'], options
          ActiveRecord::Base.establish_connection config
        end

        begin
          create_db.call config
        rescue Mysql::Error => sqlerr
          if sqlerr.errno == 1405
            print "#{sqlerr.error}. \nPlease provide the root password for your mysql installation\n>"
            root_password = $stdin.gets.strip

            grant_statement = <<-SQL
    GRANT ALL PRIVILEGES ON #{config['database']}.*
    TO '#{config['username']}'@'localhost'
    IDENTIFIED BY '#{config['password']}' WITH GRANT OPTION;
            SQL

            create_db.call config.merge('database' => nil, 'username' => 'root', 'password' => root_password)
          else
            $stderr.puts sqlerr.error
            $stderr.puts "Couldn't create database for #{config.inspect}, charset: utf8, collation: utf8_unicode_ci"
            $stderr.puts "(if you set the charset manually, make sure you have a matching collation)" if config['charset']
          end
        end
      end

      def migrate
        ActiveRecord::Migration.verbose = true
        ActiveRecord::Migrator.migrate MIGRATIONS_DIR, ENV['VERSION'] ? ENV['VERSION'].to_i : nil
      end

    end
  end
end
