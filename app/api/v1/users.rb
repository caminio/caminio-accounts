class Caminio::Sky::API::Users < Grape::API

  helpers Caminio::Sky::API::AuthHelper
  before{ authenticate! }

  resource :users do

    #
    # GET /
    #
    desc "lists all users"
    get do
      Caminio::Sky::User.where({})
    end

    #
    # GET /current
    #
    desc "return user relation of current token"
    get '/current' do
      Caminio::Sky::User.find( @token.user_id )
    end

    #
    # GET /:id
    #
    desc "returns user with :id"
    params do
      requires :id, type: Integer, desc: "the user's id"
    end
    route_param :id do
      get do
        error!('InsufficientRights', 403) unless params.id == @token.user_id || @token.user.is_admin?
        Caminio::Sky::User.find_by(id: params.id)
      end
    end

  end

end
