module Caminio::Sky::API::Entities

  class AccessToken < Grape::Entity
    root :access_tokens, :access_token
    expose :expires_at
    expose :token
  end

end
