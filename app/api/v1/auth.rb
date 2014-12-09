module Caminio::Sky::API

  module AuthMethods

    def authenticate_user
      @current_user = Caminio::Sky::User
              .where( "username=? OR email=?", params.login, params.login )
              .first
      return error!('InvalidCredentials',401) unless @current_user && @current_user.authenticate( params.password )
      @current_user.aquire_access_token
    end

  end

  class Auth < Grape::API

    helpers AuthMethods

    resource :auth do

      # ============================================================
      # POST
      desc "authenticates a user"
      params do
        requires :login, desc: "email address or username accepted"
        requires :password, desc: "the user's password"
      end
      post do
        authenticate_user
        present @current_user.access_token, root: :access_token
      end

    end

  end

end
