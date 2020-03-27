# frozen_string_literal: true

module BookingMovies
  module Services
    class MoviesService
      
      @@days_of_week = []

      def get_all_by_dates(day_of_week)
        if !day_of_week.blank? && [0..7].include? day_of_week.to_i
          movies = [{
            name: 'Movie 1',
            description: 'Description 1',
            image_url: 'http1',
            show_dates: [Date.today, Date.today, Date.today]
          },
          {
            name: 'Movie 1',
            description: 'Description 1',
            image_url: 'http1',
            show_dates: [Date.today, Date.today, Date.today]
          },
          {
            name: 'Movie 1',
            description: 'Description 1',
            image_url: 'http1',
            show_dates: [Date.today, Date.today, Date.today]
          }]
          movies.filter {|m| m[:show_dates].any? {|sd| sd.wday === day_of_week.to_i }}
        else
          
        end
      end

      def save_movie

      end
    end
  end
end
