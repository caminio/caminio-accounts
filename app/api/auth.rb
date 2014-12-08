class Caminio::Sky::API::Auth < Grape::API

  default_format :json
  format :json

  desc "authenticates a user"
  params do
    requires :login, desc: "email address or username accepted"
    requires :password, desc: "the user's password"
  end
  post '/' do
    authenticate_user!
    {}
  end

  helpers do

    def authenticate_user!
      error!('Unauthorized',401)
    end

  end

end
