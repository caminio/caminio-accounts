require 'grape'

class Caminio::Sky::API::Users < Grape::API

  helpers Caminio::Sky::API::AuthHelper
  before{ authenticate! }

  desc "lists all users"
  get '/' do
    {}
  end

end
