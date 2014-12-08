require 'grape-swagger'

module Caminio
  module Sky
    module API

      class Root < Grape::API

        desc "caminio-sky user and license management"
        version "v1"

        helpers Caminio::Sky::API::Helper

        mount API::Users => '/users'
        mount API::Auth => '/auth'

        add_swagger_documentation mount_path: 'doc', hide_documentation_path: true, api_version: self.version

      end

    end
  end
end
