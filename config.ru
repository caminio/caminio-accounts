require 'caminio/sky'

Caminio::Sky.init

map('/') { run Caminio::Sky::API::Root }
