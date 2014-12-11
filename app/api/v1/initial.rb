module Caminio::Sky::API
  
  class Initial < Grape::API

    namespace :inital do

      #
      # POST /init
      #
      desc "initial setup (allows you to create your first user account and organization)"
      params do
        requires :organization_name
        requires :email
        requires :username
        requires :password
      end
      post :init do
        return error!('SetupIsCompletedAlready',403) if Caminio::Sky::User.count > 0
        org = Caminio::Sky::Organization.create( name: params.organization_name )
        Caminio::Sky::User.create( organization_id: org.id, username: params.username, password: params.password, email: params.email )
      end

    end

  end
end
