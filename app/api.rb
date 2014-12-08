require 'grape-swagger'

module Caminio
  module Sky
    module API

      class Root < Grape::API

        desc "caminio-sky user and license management"
        prefix '/api/v1'
        helpers API::Helper

        default_format :json
        format :json

        mount API::Users
        mount API::Auth

        add_swagger_documentation mount_path: '/doc', hide_documentation_path: true

      end

    end
  end
end
