# frozen_string_literal: true

module Api
  module Endpoints
    class Bookings < Grape::API
      extend Models

      namespace :bookings do

        desc 'get all of bookings by date range', is_array: true
        params do
          # ([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))
          optional :from, type: DateTime, desc: 'From which date want to be filtered the bookings'
          optional :to, type: DateTime, desc: 'To which date want to be filtered the bookings'
        end
        get do
          range = { from: params[:from], to: params[:to] }
          bookings_service = BookingMovies::Services::BookingsService.new
          bookings_service.get_all_by_date_range range
        end

        desc 'create new booking'
        params do
          requires :movie_id, type: Integer, desc: 'Movie Identifier', allow_blank: false
          requires :date, type: DateTime, desc: 'Date to book', allow_blank: false
          requires :id_user, type: Integer, desc: 'Identifier of user booking the movie', allow_blank: false
        end
        post do
          booking = {
            date: params[:date],
            movie_id: params[:movie_id],
            id_user: params[:id_user],
          }
          movies_service = BookingMovies::Services::BookingsService.new
          movies_service.book_movie booking
        end

      end
    end
  end
end
