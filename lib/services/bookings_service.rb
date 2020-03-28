# frozen_string_literal: true
require 'logger'
require 'models'
require_relative '../../api/entities/api_error'

module BookingMovies
  module Services
    class BookingsService
      include Models
      include Api::Entities

      @@min_possible_date = '0000-01-01'
      @@max_possible_date = '9999-12-31'
      @@max_bookings_per_movie_date = 10

      # get from database the bookings with date between a range of dates
      def get_all_by_date_range(range)
        begin 
          # set range of dates
          from = range[:from].present? ? range[:from].strftime("%Y-%m-%d") : @@min_possible_date
          to = range[:to].present? ? range[:to].strftime("%Y-%m-%d") : @@max_possible_date
          # query movie dates on dates range
          movie_dates = MovieDate.where(Sequel.lit("date >= '#{from}' and date <= '#{to}'")).all
          movie_dates = movie_dates.filter{|md| md.bookings.any? }
          # map booking
          bookings = []
          movie_dates.each do |md|
            md.bookings.each do |b|
              bookings << {
                booking_id: b.id,
                movie_id: md.movie.id,
                movie_name: md.movie.name,
                booking_date: md.date,
                id_user: b.id_user
              }
            end
          end
          bookings
        rescue
          ApiError.new({ code: 500, message: "Error - please try again or contact the administrator" })
        end
      end

      # create a new booking for an existing movie on a specific date if there is a room available
      def book_movie(booking)
        begin
          # check if booking exist
          movie_date = MovieDate.first(date: booking[:date], movie_id: booking[:movie_id])
          return ApiError.new({ code: 404, message: "There is no function of this movie on #{booking[:date].strftime("%Y-%m-%d")}" }) if movie_date.nil?
          # check if there is room for another reservation for this movie
          return ApiError.new({ code: 403, message: "No more quotas for this movie on #{booking[:date].strftime("%Y-%m-%d")}" }) if movie_date.bookings.count === @@max_bookings_per_movie_date
          # create booking
          persisted_booking = Booking.create(movie_date_id: movie_date.id, id_user: booking[:id_user])
          { booking: persisted_booking.values }
        rescue
          ApiError.new({ code: 500, message: "Error - please try again or contact the administrator" })
        end
      end

    end
  end
end
