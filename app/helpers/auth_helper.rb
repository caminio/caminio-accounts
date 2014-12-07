module Caminio::Sky::API::AuthHelper

  def authenticate!
    error!('Unauthorized', 401) unless current_user
  end

  def current_user
    false
  end

end
