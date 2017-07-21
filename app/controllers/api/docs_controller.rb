module Api
  class DocsController < ActionController::Base
    protect_from_forgery with: :exception

    include Swagger::Blocks

    # :nocov:
    swagger_root do
      key :swagger, '2.0'
      info do
        key :version, '1.0.0'
        key :title, 'EveMonk back-end REST API'
        key :description, 'EveMonk back-end REST API documentation'
      end
      tag do
        key :name, 'sign up'
        key :description, 'Sign Up operations'
      end
      tag do
        key :name, 'sign in'
        key :description, 'Sign In operations'
      end
      tag do
        key :name, 'sign out'
        key :description, 'Sign Out operations'
      end
      tag do
        key :name, 'profile'
        key :description, 'Profile operations'
      end
      key :host, (ENV['SWAGGER_BLOCKS_HOST'] || 'localhost:3000')
      key :basePath, '/api'
      key :consumes, ['application/json']
      key :produces, ['application/json']
      parameter :authorization do
        key :name, 'Authorization'
        key :in, :header
        key :description, 'User auth token. Example: Bearer AAkoMiLatQHMngyuUU1vnh5b'
        key :default, 'Bearer ACCESS_TOKEN'
        key :required, true
        key :type, :string
      end
      parameter :page do
        key :name, :page
        key :in, :query
        key :description, 'Page number. Default: 1'
        key :required, false
        key :type, :integer
        key :format, :int64
      end
    end
  
    # A list of all classes that have swagger_* declarations.
    SWAGGERED_CLASSES = [
      Api::Docs::Models::OutputSession,

      self
    ].freeze
    # :nocov:
  
    def index
      render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
    end
  end
end
