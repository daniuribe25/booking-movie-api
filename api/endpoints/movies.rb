# frozen_string_literal: true

module Api
  module Endpoints
    class Movies < Grape::API
      namespace :movies do
        desc 'create movie'
        params do
          # TODO: specify the parameters
          requires :day_of_week, type: Integer, desc: 'number of day of the week starting from 0 being Sunday to filter movies'
        end
        post do
          # your code goes here
        end

        desc 'get all of movies', is_array: true
        get do
          puts params[:day_of_week]
          movies_service = BookingMovies::Services::MoviesService.new
          movies_service.get_all_by_dates params[:day_of_week]
        end

        desc 'get specific movie'
        params do
          requires :id
        end
        get ':id' do
          # your code goes here
        end
      end
    end
  end
end
