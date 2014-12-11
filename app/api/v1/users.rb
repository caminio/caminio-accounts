class Caminio::Sky::API::Users < Grape::API

  helpers Caminio::Sky::API::AuthHelper
  helpers do

    def user_params
      user_params = declared(params)[:user]
      user_params.delete(:organization_id) unless current_user.is_admin?
      user_params
    end

  end

  before{ authenticate! }

  formatter :json, Grape::Formatter::ActiveModelSerializers

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

    #
    # POST /
    #
    desc "create a new user within the new group"
    params do
      requires :user, type: Hash do
        requires :email
        optional :username
        optional :firstname
        optional :lastname
        optional :password
        optional :organization_id
        optional :role, values: ['user','admin'], default: 'user'
      end
    end
    post do
      Caminio::Sky::User.create( user_params )
    end

    #
    # POST /change_password
    #
    desc "changes the password for the current user"
    params do
      requires :old, desc: "the current password"
      requires :new, desc: "the new password"
    end
    post '/change_password' do
      user = Caminio::Sky::User.find( @token.user_id )
      return error("password failed",403) unless user.authenticate( params.old )
      user.password = params.new
      return error("failed to save", 422) unless user.save
      Caminio::Sky::User.find( @token.user_id )
    end

    #
    # PUT /:id
    #
    desc "update an existing user"
    params do
      requires :user, type: Hash do
        optional :email
        optional :username
        optional :firstname
        optional :lastname
        optional :password
        optional :organization_id
        optional :role, values: ['user','admin'], default: 'user'
      end
    end
    put '/:id' do
      Caminio::Sky::User.update( params.id, user_params )
      Caminio::Sky::User.find( params.id )
    end

    #
    # DELETE /:id
    #
    desc "delete an existing user"
    formatter :json, lambda{ |o,env| "{}" }
    delete '/:id' do
      Caminio::Sky::User.destroy( params.id )
    end

  end

end
