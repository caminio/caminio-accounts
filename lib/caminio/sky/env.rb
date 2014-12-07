module Caminio
  module Sky
    def self.env
      ENV['RACK_ENV'] || 'development'
    end
  end
end
