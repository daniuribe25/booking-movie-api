# frozen_string_literal: true
require 'models'

module BookingMovies
  module Services
    class MoviesService
      include Models

      def get_all_by_week_day(week_day)
        begin
          MovieDate.where(week_day: week_day).map{|md| md.values}
        rescue
          ApiError.new({ code: 500, message: "Error - please try again or contact the administrator" })
        end
      end

      def create_movie(movie)
        begin
          persisted_movie = Movie.create(name: movie[:name], image_url: movie[:image_url])
          movie[:dates].each do |date|
            week_day = (Date.parse date).wday
            MovieDate.create(date: date, movie_id: persisted_movie.id, week_day: week_day)
          end
          { movie: persisted_movie.values }
        rescue
          ApiError.new({ code: 500, message: "Error - please try again or contact the administrator" })
        end
      end

    end
  end
end
