class Caminio::Sky::API::Users < Grape::API

  # default_format :json
  # format :json
  #
  # helpers Caminio::Sky::API::AuthHelper
  # before{ authenticate! }

  resource :users do
    desc "lists all users"
    get do
      []
    end
  end

end
