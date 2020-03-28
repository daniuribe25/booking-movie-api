# frozen_string_literal: true

require 'rake'
require 'sequel'

Sequel::Model.db = Sequel.connect("postgres://bookingmovies:Paxwork1!@localhost:4321/booking_movies?encoding=utf8&max_connections=4")

require File.expand_path('config/application', __dir__)

task :environment do
  ENV['RACK_ENV'] ||= 'development'
end

Dir.glob("db/*.rake").each { |r| import r }

# rspec tasks
require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

# rubocop tasks
require 'rubocop/rake_task'
RuboCop::RakeTask.new(:rubocop)

task default: %i[spec rubocop]

# grape-swagger tasks
require 'grape-swagger/rake/oapi_tasks'
GrapeSwagger::Rake::OapiTasks.new(::Api::Base)

# starter tasks
require 'starter/rake/grape_tasks'
Starter::Rake::GrapeTasks.new(::Api::Base)
