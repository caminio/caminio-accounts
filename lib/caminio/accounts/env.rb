module Caminio
  module Accounts
    def self.env
      ENV['RACK_ENV'] || 'development'
    end
  end
end
