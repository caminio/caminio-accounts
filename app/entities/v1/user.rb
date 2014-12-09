module Caminio::Sky::API::Entities

  class User < Grape::Entity
    root :users, :user
    expose :username
  end

end
