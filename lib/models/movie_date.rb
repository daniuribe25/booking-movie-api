# frozen_string_literal: true

module Models
  class MovieDate < Sequel::Model
    many_to_one :movie
    one_to_many :bookings
  end
end