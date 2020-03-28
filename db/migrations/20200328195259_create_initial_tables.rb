Sequel.migration do
    up do
        create_table(:movies) do
            primary_key :id
            String      :name
            String      :image_url
        end

        create_table(:movie_dates) do
            primary_key :id
            foreign_key :movie_id, :movies
            DateTime    :date
            Integer     :week_day
        end

        create_table(:bookings) do
            primary_key  :id
            foreign_key  :movie_date_id, :movie_dates
            Integer      :id_user
        end
    end

    down do
        drop_table(:movies)
        drop_table(:movie_dates)
        drop_table(:bookings)
    end
end