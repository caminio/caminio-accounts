require 'grape'

class Caminio::Sky::API::Auth < Grape::API

  desc "authenticates a user"
  params do
    requires :login, desc: "email address or username accepted"
    requires :password, desc: "the user's password"
  end
  post '/' do
    {}
  end

end
