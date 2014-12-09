module Caminio::Sky::API

  module AuthHelper

    def authenticate!
      error!('Unauthorized', 401) unless try_authorize_token
    end

    def try_authorize_token
      if token = headers['Authorization']
        token = token.split(' ').last
      elsif params.api_key
        token = params.api_key
      end
      logger.info "having token #{token}"
      error!('MissingTokenOrApiKey', 409) unless token
      return false unless @token = Caminio::Sky::AccessToken.find_by( token: token )
      @token.expires_at > Time.now
    end

  end

end
