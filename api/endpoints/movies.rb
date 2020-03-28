# frozen_string_literal: true

module Api
  module Endpoints
    class Movies < Grape::API
      extend Models

      namespace :movies do

        desc 'get all of movies by week day', is_array: true
        params do
          requires :week_day, allow_blank: false, values: { value: 0..6, message: 'must be a value in range from 0 to 6 being 0 Sunday' }, type: Integer, desc: 'number of day of the week starting from 0 being Sunday to filter movies'
        end
        get do
          movies_service = BookingMovies::Services::MoviesService.new
          movies_service.get_all_by_week_day params[:week_day]
        end

        desc 'create movie'
        params do
          requires :name, type: String, desc: 'Name of movie', allow_blank: false
          requires :image_url, type: String, desc: 'Movie image url', allow_blank: false
          requires :dates, type: Array[String], desc: 'Dates when movie will be shown', allow_blank: false
        end
        post do
          movie = {
            name: params[:name],
            image_url: params[:image_url],
            dates: params[:dates],
          }
          movies_service = BookingMovies::Services::MoviesService.new
          movies_service.create_movie movie
        end

      end
    end
  end
end
