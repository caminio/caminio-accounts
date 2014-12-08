module Caminio::Sky::API

  module AuthMethods

    def authenticate_user
      @current_user = Caminio::Sky::User
              .where( "username=? OR email=?", params.login, params.login )
              .first
      return error!('InvalidCredentials',401) unless @current_user.authenticate( params.password )
    end

  end

  class Auth < Grape::API

    helpers AuthMethods

    resource :auth do

      desc "authenticates a user"
      params do
        requires :login, desc: "email address or username accepted"
        requires :password, desc: "the user's password"
      end
      post do
        authenticate_user
        @current_user
      end

    end

  end

end
