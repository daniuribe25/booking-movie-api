## Booking Movies API

An awesome API used to create movies and book specific dater for each movie.
It is built with Grape Gem to make it easier to implement api routing and and input validations, using Sequel as database query toolkit

## Usage

#### Create Movies

post [http://localhost:port/api/v1/movies](http://localhost:9292/doc)
{
  "name": String,
  "image_url": String,
  "dates": [String]
}

Response success example: {
  code: 200, booking: {
    id: Number
    name: String
    image_url: String
  }
}

Response error example: {
  code: (500), message: String
}

#### Get Movies By Week Day

get [http://localhost:port/api/v1/movies?week_day=](http://localhost:9292/api/v1/movies?week_day=)

week_day must be a number from 0 being Sunday to 6 being Saturday

Response success example: {
  code: 200, movies: [{
    id: Number,
    name: String,
    image_url: String
  }]
}

Response error example: {
  code: 500, message: String
}

#### Create Booking

post [http://localhost:port/api/v1/bookings](http://localhost:9292/api/v1/bookings)
{
  "movie_id": Number,
  "date": String Date, // "yyyy-mm-dd"
  "id_user": String
}

Response success example: {
  code: 200, booking: {
    id: Number,
    movie_date_id: Number,
    id_user: Number
  }
}

Response error example: {
  code: (500| 404| 403), message: String
}


#### Get Bookings

get [http://localhost:port/api/v1/bookings?from=&to=](http://localhost:9292/api/v1/bookings?from=&to=)

from= String Date "yyyy-mm-dd"
to= String Date "yyyy-mm-dd"

Response success example: {
  code: 200, bookings: [{
    booking_id: Number,
    movie_id: Number,
    movie_name: String,
    booking_date: Date,
    id_user: String
  }]
}

Response error example: {
  code: 500, message: String
}

To run it locally you will need the last version of Ruby, then follow these steps:

## `Get Project`

First clone the project and access the folder
```
git clone https://github.com/daniuribe25/booking-movie-api.git

cd booking-movie-api
```

#### `Setup`

Run:
```
bundle install
```

Create a new PG Database 
```
CREATE USER bookingmovies WITH PASSWORD 'Paxwork1!';
CREATE DATABASE booking_movies WITH ENCODING 'UTF8';
GRANT ALL PRIVILEGES ON DATABASE booking_movies TO bookingmovies
CREATE DATABASE booking_movies_test WITH ENCODING 'UTF8';
GRANT ALL PRIVILEGES ON DATABASE booking_movies_test TO bookingmovies
```

Migrate Database by running
```
rake db:migrate
```
if you encountered any issue comment in model's content like
```
class Movie
  # < Sequel::Model
  # one_to_many :movie_dates
end
```
then run the migration again

#### `Test`

Running tests
```
$ ./script/test
```

#### `Run`

Running local server
```
$ ./script/server *port (default: 9292)
```
and go to: [http://localhost:port/doc](http://localhost:9292/doc)
to access the OAPI documentation.

For production, set `RACK_ENV=production`
```
$ RACK_ENV=production ./script/server *port (default: 9292)
```

#### `Update`

… dependencies
```
$ ./script/update
```

#### `Stop`

… would only be used, if server started in production mode
```
$ ./script/stop
```

#### List Routes

```
rake routes
```

#### OpenApi Documentation and Validation

```
rake oapi:fetch
rake oapi:validate
```
comming from: [`grape-swagger` Rake Tasks](https://github.com/ruby-grape/grape-swagger#rake-tasks)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/daniuribe25/booking-movie-api.git.