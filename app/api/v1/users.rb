class Caminio::Sky::API::Users < Grape::API

  helpers Caminio::Sky::API::AuthHelper
  before{ authenticate! }

  resource :users do
    desc "lists all users"
    get do
      []
    end
  end

end
