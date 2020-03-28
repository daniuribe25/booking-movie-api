# frozen_string_literal: true

module Api
  class Base < Grape::API
    version 'v1', using: :path
    format :json
    prefix :api
    
    mount Endpoints::Root
    mount Endpoints::Movies
    mount Endpoints::Bookings

    add_swagger_documentation format: :json,
                              info: {
                                title: 'Starter API'
                              },
                              mount_path: '/oapi',
                              models: [
                                Entities::ApiError
                              ]
  end
end
