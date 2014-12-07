require 'caminio/sky/sequel/plugins/secure_password'

class Caminio::Sky::User < Sequel::Model
  plugin :secure_password
end
