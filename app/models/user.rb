module Caminio::Sky

  class User < ActiveRecord::Base
    has_secure_password
    has_one :access_token, dependent: :delete

    def aquire_access_token
      AccessToken.where( user_id: id ).delete_all
      create_access_token
    end

  end

end
