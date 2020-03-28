# frozen_string_literal: true

module Models
  class Movie < Sequel::Model
    one_to_many :movie_dates
  end
end