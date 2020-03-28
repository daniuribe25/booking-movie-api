namespace :db do
    require "sequel"
  
    Sequel.extension :migration
  
    DB = Sequel.connect("postgres://bookingmovies:Paxwork1!@localhost:4321/booking_movies?encoding=utf8&max_connections=4")
  
    desc "Prints current schema version"
  
    def get_last_version
      version = if DB.tables.include?(:schema_migrations)
        last_record = DB[:schema_migrations].order(:filename).last
        last_record[:filename].split("_")[0].to_i if last_record
      end || 0
    end
  
    def get_rollback_version
      version = if DB.tables.include?(:schema_migrations)
        last_record = DB[:schema_migrations].all[-2]
        last_record[:filename].split("_")[0].to_i if last_record
      end || 0
    end
  
    task :version do
      puts "Schema Version: #{get_last_version}"
    end
  
    desc "Perform migration up to latest migration available"
    task :migrate do
      Sequel::Migrator.run(DB, "db/migrations")
      Rake::Task["db:version"].execute
    end
  
    desc "Perform rollback to specified target or full rollback as default"
    task :rollback, :target do |t, args|
      args.with_defaults(:target => get_rollback_version)
      Sequel::Migrator.run(DB, "db/migrations", :target => args[:target].to_i)
      Rake::Task["db:version"].execute
    end
  
    desc "Perform migration reset (full rollback and migration)"
    task :reset do
      Sequel::Migrator.run(DB, "db/migrations", :target => 0)
      Sequel::Migrator.run(DB, "db/migrations")
      Rake::Task["db:version"].execute
    end
  
    task seed: :migrate do
      load "db/seeds.rb"
    end

end