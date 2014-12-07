require 'grape'
require 'grape-swagger'

class Caminio::Sky::API::Users < Grape::API

  desc "lists all users"
  get '/' do
    {}
  end

end
