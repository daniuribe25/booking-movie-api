# frozen_string_literal: true

module Models
  class Booking < Sequel::Model
    many_to_one :movie_date
  end
end