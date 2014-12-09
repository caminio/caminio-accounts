require 'caminio/sky'
require 'rack/cors'
require 'request_store'

use RequestStore::Middleware
use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: [ :get, :post, :put, :delete, :options ]
  end
end

Caminio::Sky.init

map('/') { run Caminio::Sky::API::Root }
