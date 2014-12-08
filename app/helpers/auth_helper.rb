module Caminio::Sky::API::AuthHelper

  def authenticate!
    puts "request is #{request.url.inspect}"
    return if request.url == 'doc.json'
    error!('Unauthorized', 401) unless current_user
  end

  def current_user
    false
  end

end
