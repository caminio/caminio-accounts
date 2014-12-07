require 'grape'
require 'grape-swagger'

module Caminio
  module Sky
    module API

      class Root < Grape::API

        def self.enable_cors
          before do
            header['Access-Control-Allow-Origin'] = '*'
            header['Access-Control-Request-Method'] = '*'
          end
        end

        enable_cors

        mount API::Users => '/users'
        add_swagger_documentation mount_path: 'doc.json'

      end

    end
  end
end
